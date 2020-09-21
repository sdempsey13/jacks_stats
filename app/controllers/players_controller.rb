class PlayersController < ApplicationController

def create_all_players
  # Get a list of players from a team
  response = open("https://statsapi.web.nhl.com/api/v1/teams/1?expand=team.roster").read
  json = JSON.parse(response)
  team_array = json["teams"]
  puts team_array[0]["roster"]

  redirect_to :root
end

end
