class MissionsController < ApplicationController
  def index
    @missions = Mission.all
  end

  def new
    @mission = Mission.find(params[:mission_id])
  end

  def create
    mission = Mission.new(params)
    mission.save
    redirect_to mission_path(mission)
  end

end
