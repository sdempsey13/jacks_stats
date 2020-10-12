class ApplicationController < ActionController::Base
  require "open-uri"

  def populate_all_website_data
    response = open("https://statsapi.web.nhl.com/api/v1/teams").read
    json = JSON.parse(response)
    response_teams = json["teams"]

    response_teams.each do |team|
      t = Team.new
      t.nhl_id = team["id"]
      t.name = team["name"]
      t.save

      response = open("https://statsapi.web.nhl.com/api/v1/teams/#{t.nhl_id}?expand=team.roster").read
      json = JSON.parse(response)
      players = json["teams"][0]["roster"]["roster"]

      players.each do |player|
        p = Player.new
        p.nhl_id = player["person"]["id"]
        p.name = player["person"]["fullName"]
        p.number = player["jerseyNumber"]
        p.position = player["position"]["name"]
        p.team_id = t.id
        p.save

        response = open("https://statsapi.web.nhl.com/api/v1/people/#{p.nhl_id}/stats?stats=statsSingleSeason&season=20192020").read
        json = JSON.parse(response)
        stats = json["stats"]

        stats.each do |stat|
          s = SkaterStat.new
          begin
            s.season_year = stat["splits"][0]["season"]
            s.season_type = stat["type"]["gameType"]["description"]
            s.games = stat["splits"][0]["stat"]["games"]
            s.shots = stat["splits"][0]["stat"]["shots"]
            s.goals = stat["splits"][0]["stat"]["goals"]
            s.player_id = p.id
            s.save
          rescue StandardError => e
            print e
          end
        end
      end
    end

    redirect_to :root
  end

  def delete_all_website_data
    SkaterStat.delete_all
    Player.delete_all
    Team.delete_all

    redirect_to :root
  end
end
