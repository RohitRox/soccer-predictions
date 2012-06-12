require './config/data.rb'

class SeedData
  # source http://www.uefa.com/uefaeuro/season=2012/matches/byround/index.html
  def self.create_matches
    # Matchday 1
    Match.create(team_a: "Poland", team_b: "Greece", group: "Group A", kick_off_time: "06/8 18:00")
    Match.create(team_a: "Russia", team_b: "Czech Republic", group: "Group A", kick_off_time: "06/8 20:45")
                
    Match.create(team_a: "Netherlands", team_b: "Denmark", group: "Group B", kick_off_time: "06/9 18:00")
    Match.create(team_a: "Germany", team_b: "Portugal", group: "Group B", kick_off_time: "06/9 20:45")
                
    Match.create(team_a: "Spain", team_b: "Italy", group: "Group C", kick_off_time: "06/10 18:00")
    Match.create(team_a: "Republic of Ireland", team_b: "Croatia", group: "Group C", kick_off_time: "06/10 20:45")
                
    Match.create(team_a: "France", team_b: "England", group: "Group D", kick_off_time: "06/11 18:00")
    Match.create(team_a: "Ukraine", team_b: "Sweden", group: "Group D", kick_off_time: "06/11 20:45")
    
    # Matchday 2
    Match.create(team_a: "Greece", team_b: "Czech Republic", group: "Group A", kick_off_time: "06/12 18:00")
    Match.create(team_a: "Poland", team_b: "Russia", group: "Group A", kick_off_time: "06/12 20:45")
                
    Match.create(team_a: "Denmark", team_b: "Portugal", group: "Group B", kick_off_time: "06/13 18:00")
    Match.create(team_a: "Netherlands", team_b: "Germany", group: "Group B", kick_off_time: "06/13 20:45")
                
    Match.create(team_a: "Italy", team_b: "Croatia", group: "Group C", kick_off_time: "06/14 18:00")
    Match.create(team_a: "Spain", team_b: "Republic of Ireland", group: "Group C", kick_off_time: "06/14 20:45")
                
    Match.create(team_a: "Ukraine", team_b: "France", group: "Group D", kick_off_time: "06/15 18:00")
    Match.create(team_a: "Sweden", team_b: "England", group: "Group D", kick_off_time: "06/15 20:45")
    
    # Matchday 3
    Match.create(team_a: "Greece", team_b: "Russia", group: "Group A", kick_off_time: "06/16 20:45")
    Match.create(team_a: "Czech Republic", team_b: "Poland", group: "Group A", kick_off_time: "06/16 20:45")
                
    Match.create(team_a: "Portugal", team_b: "Netherlands", group: "Group B", kick_off_time: "06/17 20:45")
    Match.create(team_a: "Denmark", team_b: "Germany", group: "Group B", kick_off_time: "06/17 20:45")
                
    Match.create(team_a: "Croatia", team_b: "Spain", group: "Group C", kick_off_time: "06/18 20:45")
    Match.create(team_a: "Italy", team_b: "Republic of Ireland", group: "Group C", kick_off_time: "06/18 20:45")
                
    Match.create(team_a: "Sweden", team_b: "France", group: "Group D", kick_off_time: "06/19 20:45")
    Match.create(team_a: "England", team_b: "Ukraine", group: "Group D", kick_off_time: "06/19 20:45")
    
    
    # QuarterFinals
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/21 20:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/22 20:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/23 20:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/24 20:45")
    
    # SemiFinals
    Match.create(team_a: "TBD", team_b: "TBD", group: "Semi-finals", kick_off_time: "06/27 20:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Semi-finals", kick_off_time: "06/28 20:45")
    
    # Final
    Match.create(team_a: "TBD", team_b: "TBD", group: "Final", kick_off_time: "07/01 20:45")
  end
end