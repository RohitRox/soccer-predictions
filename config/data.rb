require 'data_mapper'
require 'bcrypt'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Match
  include DataMapper::Resource
  
  TEAMS = [
    "Croatia",
    "Czech Republic",
    "Denmark",
    "England",
    "France",
    "Germany",
    "Greece",
    "Italy",
    "Netherlands",
    "Poland",
    "Portugal",
    "Republic of Ireland",
    "Russia",
    "Spain",
    "Sweden",
    "Ukraine"
  ]

  property :id, Serial
  property :team_a, String, required: true, set: [*TEAMS, "TBD"]
  property :team_b, String, required: true, set: [*TEAMS, "TBD"]
  property :kick_off_date, Date, required: true
  property :kick_off_time, DateTime, required: true
  property :group, String 
  property :score, String

  timestamps :created_at, :updated_at
  
  has n, :predictions
  
  def kick_off_time=(time)
    self[:kick_off_time] = time.is_a?(String) ? DateTime.strptime("#{time} +0000", "%m/%d %H:%M %z") : time
    self[:kick_off_date] = self[:kick_off_time].to_date
    self[:kick_off_time]
  end
  
  def competitors_not_decided?
    [self.team_a, self.team_b].include?("TBD")
  end
  
  # if the deadline for prediction has passed
  def prediction_deadline_passed?
    ((self.kick_off_time - DateTime.now) * 24 * 60).to_f <= 10
  end
  
  
  def open_for_prediction?
    !prediction_deadline_passed? && !competitors_not_decided?
  end
  
  class << self
    def all_grouped_by_kick_off_date(limit = nil)
      options = { :kick_off_date.lte => Date.today, order: [:kick_off_time.desc] }
      options[:limit] = limit if limit
      all(options).group_by(&:kick_off_date)
    end
  end
  
end


class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation

  timestamps :created_at, :updated_at

  property :id,           Serial
  property :crypted_pass, String,   :length => 60..60, :required => true, :writer => :protected
  property :email,        String,   :length => 5..200, :required => true,
  :format => :email_address
  
  has n, :predictions

  validates_presence_of :password, :password_confirmation, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  before :valid?, :crypt_password

  # check validity of password if we have a new resource, or there is a plaintext password provided
  def password_required?
    new? or password
  end

  def reset_password(password, confirmation)
    update(:password => password, :password_confirmation => confirmation)
  end

  # Hash the password using BCrypt
  #
  # BCrypt is a lot more secure than a hash made for speed such as the SHA algorithm. BCrypt also
  # takes care of adding a salt before hashing.  The whole thing is encoded in a string 60 bytes long.
  def crypt_password
    self.crypted_pass = BCrypt::Password.create(password) if password
  end

  # Prepare a BCrypt hash from the stored password, overriding the default reader
  #
  # return the `:no_password` symbol if the property has no content.  This is for
  # the safety of the authenticate method.  It's easy to pass a nil password to 
  # that method, but passing a specific symbol takes effort.
  def crypted_pass
    pass = super
    if pass
      BCrypt::Password.new(pass)
    else
      :no_password
    end
  end

  def authenticate(password)
    crypted_pass == password
  end

  def self.authenticate(email, password)
    email = email.to_s.downcase
    u = first(:conditions => ['lower(email) = ?', email])
    if u && u.authenticate(password)
      u
    else
      nil
    end
  end
  
  
  # the prediction for the match
  def prediction_for(match)
    self.predictions.first(match_id: match.id)
  end
  
end


class Prediction
  include DataMapper::Resource 
  
  property :id, Serial
  property :result, String, required: true, set: [*Match::TEAMS, "Draw"]
  
  timestamps :created_at, :updated_at
  
  belongs_to :match
  belongs_to :user
  
  
  def message
    case self.result
    when "Draw"; "You Predicted this match will be a draw"
    else; "You predicted #{self.result} will win this match"
    end
  end
end

DataMapper.finalize


DataMapper.auto_upgrade!