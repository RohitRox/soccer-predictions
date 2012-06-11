require 'data_mapper'
require 'bcrypt'


DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/development.db")

class Match
  include DataMapper::Resource

  property :id, Serial
  property :team_a, String, required: true
  property :team_b, String, required: true
  property :kick_off_date, Date, required: true
  property :kick_off_time, Time, required: true
  property :group, String 
  property :score, String

  timestamps :created_at, :updated_at
end


class User
  include DataMapper::Resource

  attr_accessor :password, :password_confirmation

  timestamps :created_at, :updated_at

  property :id,           Serial
  property :crypted_pass, String,   :length => 60..60, :required => true, :writer => :protected
  property :email,        String,   :length => 5..200, :required => true,
  :format => :email_address

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
end



DataMapper.finalize


DataMapper.auto_upgrade!