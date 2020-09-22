class PlayersController < ApplicationController

  def create_all_players
    # Get a list of players from a team
    response = open("https://statsapi.web.nhl.com/api/v1/teams/1?expand=team.roster").read
    json = JSON.parse(response)
    players = json["teams"][0]["roster"]["roster"]

    players.each do |player|
      puts player
      p = Player.new
      p.name = player["person"]["fullName"]
      p.number = player["jerseyNumber"]
      p.position = player["position"]["name"]
      p.team_id = 342
      p.save
    end

    redirect_to :root
  end

  def delete_all_players
    Player.delete_all

    redirect_to :root
  end
end
