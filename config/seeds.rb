require './config/data.rb'

class SeedData
  # source http://www.uefa.com/uefaeuro/season=2012/matches/byround/index.html
  def self.create_matches
    # Matchday 1
    Match.create(team_a: "Poland", team_b: "Greece", group: "Group A", kick_off_time: "06/8 17:00")
    Match.create(team_a: "Russia", team_b: "Czech Republic", group: "Group A", kick_off_time: "06/8 19:45")

    Match.create(team_a: "Netherlands", team_b: "Denmark", group: "Group B", kick_off_time: "06/9 17:00")
    Match.create(team_a: "Germany", team_b: "Portugal", group: "Group B", kick_off_time: "06/9 19:45")

    Match.create(team_a: "Spain", team_b: "Italy", group: "Group C", kick_off_time: "06/10 17:00")
    Match.create(team_a: "Republic of Ireland", team_b: "Croatia", group: "Group C", kick_off_time: "06/10 19:45")

    Match.create(team_a: "France", team_b: "England", group: "Group D", kick_off_time: "06/11 17:00")
    Match.create(team_a: "Ukraine", team_b: "Sweden", group: "Group D", kick_off_time: "06/11 19:45")

    # Matchday 2
    Match.create(team_a: "Greece", team_b: "Czech Republic", group: "Group A", kick_off_time: "06/12 17:00")
    Match.create(team_a: "Poland", team_b: "Russia", group: "Group A", kick_off_time: "06/12 19:45")

    Match.create(team_a: "Denmark", team_b: "Portugal", group: "Group B", kick_off_time: "06/13 17:00")
    Match.create(team_a: "Netherlands", team_b: "Germany", group: "Group B", kick_off_time: "06/13 19:45")

    Match.create(team_a: "Italy", team_b: "Croatia", group: "Group C", kick_off_time: "06/14 17:00")
    Match.create(team_a: "Spain", team_b: "Republic of Ireland", group: "Group C", kick_off_time: "06/14 19:45")

    Match.create(team_a: "Ukraine", team_b: "France", group: "Group D", kick_off_time: "06/15 17:00")
    Match.create(team_a: "Sweden", team_b: "England", group: "Group D", kick_off_time: "06/15 19:45")

    # Matchday 3
    Match.create(team_a: "Greece", team_b: "Russia", group: "Group A", kick_off_time: "06/16 19:45")
    Match.create(team_a: "Czech Republic", team_b: "Poland", group: "Group A", kick_off_time: "06/16 19:45")

    Match.create(team_a: "Portugal", team_b: "Netherlands", group: "Group B", kick_off_time: "06/17 19:45")
    Match.create(team_a: "Denmark", team_b: "Germany", group: "Group B", kick_off_time: "06/17 19:45")

    Match.create(team_a: "Croatia", team_b: "Spain", group: "Group C", kick_off_time: "06/18 19:45")
    Match.create(team_a: "Italy", team_b: "Republic of Ireland", group: "Group C", kick_off_time: "06/18 19:45")

    Match.create(team_a: "Sweden", team_b: "France", group: "Group D", kick_off_time: "06/19 19:45")
    Match.create(team_a: "England", team_b: "Ukraine", group: "Group D", kick_off_time: "06/19 19:45")


    # QuarterFinals
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/21 19:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/22 19:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/23 19:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Quarter-finals", kick_off_time: "06/24 19:45")

    # SemiFinals
    Match.create(team_a: "TBD", team_b: "TBD", group: "Semi-finals", kick_off_time: "06/27 19:45")
    Match.create(team_a: "TBD", team_b: "TBD", group: "Semi-finals", kick_off_time: "06/28 19:45")

    # Final
    Match.create(team_a: "TBD", team_b: "TBD", group: "Final", kick_off_time: "07/01 19:45")
  end
end