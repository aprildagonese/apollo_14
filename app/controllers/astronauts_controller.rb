class AstronautsController < ApplicationController
  def index
    @astronauts = Astronaut.all
  end

  def new
    @astronaut = Astronaut.find(params[:astronaut_id])
  end

  def create
    astronaut = Astronaut.new(params)
    astronaut.save
    redirect_to astronaut_path(astronaut)
  end

end
