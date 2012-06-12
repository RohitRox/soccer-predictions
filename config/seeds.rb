require './config/data.rb'

class SeedData
  # source http://www.uefa.com/uefaeuro/season=2012/matches/byround/index.html
  def self.create_group_stage_matches
    
    # Matchday 2
    Match.create(team_a: "Greece", team_b: "Czech Republic", group: "Group A", kick_off_time: "06/12 18:00")
    Match.create(team_a: "Poland", team_b: "Russia", group: "Group A", kick_off_time: "06/12 20:45")
                
    Match.create(team_a: "Denmark", team_b: "Portugal", group: "Group B", kick_off_time: "06/13 18:00")
    Match.create(team_a: "Netherlands", team_b: "Germany", group: "Group B", kick_off_time: "06/13 20:45")
                
    Match.create(team_a: "Italy", team_b: "Croatia", group: "Group C", kick_off_time: "06/14 18:00")
    Match.create(team_a: "Spain", team_b: "Republic of Ireland", group: "Group C", kick_off_time: "06/14 20:45")
                
    Match.create(team_a: "Ukraine", team_b: "France", group: "Group D", kick_off_time: "06/15 18:00")
    Match.create(team_a: "Sweden", team_b: "England", group: "Group D", kick_off_time: "06/15 20:45")
  end
end