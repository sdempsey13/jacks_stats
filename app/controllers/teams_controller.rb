class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  require "open-uri"
  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    @players = Player.all
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to @team, notice: 'Team was successfully created.' }
        format.json { render :show, status: :created, location: @team }
      else
        format.html { render :new }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to @team, notice: 'Team was successfully updated.' }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url, notice: 'Team was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_all_teams
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
        stats = json["stats"][0]["splits"][0]["season"]
        puts stats
      end
    end

    redirect_to :root
  end

  def delete_all_teams
    Team.delete_all

    redirect_to :root
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :location)
    end
end
