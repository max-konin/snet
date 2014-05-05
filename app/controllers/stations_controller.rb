class StationsController < ApplicationController
  before_action :set_job
  before_action :set_station, only: [:show, :destroy]
  respond_to :json
  # GET /regions
  # GET /regions.json
  def index
    @stations = @job.stations
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @station = @job.build_station
  end

  # GET /regions/1/edit
  def edit
  end

  def connect
    params[:edges].each do |edge|
      source = @job.stations.find(edge[:source].to_i).first
      target = @job.stations.find(edge[:target].to_i).first
      source.connections.create(target,
                                weight: edge[:weight].to_i) unless source.nil? || target.nil? || edge[:weight].blank?
    end
    head :ok
  end

  # POST /regions
  # POST /regions.json
  def create
    @station = @job.create_station!
    if @station.save
      respond_with [@job, @station], status: :created
    else
      respond_with @station.errors, status: :unprocessable_entity
    end

  end
  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @station.destroy
    head :no_content
  end

  def dotting
   if @job.dotting_stations! @job.stations_capacity
     redirect_to job_stations_path(@job)
   else
     status 500
   end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_station
      @station = Region.find(params[:id])
      raise ActiveRecordError::RecordNotFound if @station.blank? || !(@station.is_a? Station)
    end

    def set_job
      @job = Job.find params[:job_id]
    end

end
