class RegionsController < ApplicationController
  before_action :set_job
  before_action :set_region, only: [:show, :edit, :update, :destroy]
  respond_to :json
  # GET /regions
  # GET /regions.json
  def index
    @regions = @job.regions
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = @job.build_region
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = @job.create_region!
    params[:region][:points].each { |p| @region.points << Point.create(p)}
    if @region.save
      respond_with [@job, @region], status: :created
    else
      respond_with @region.errors, status: :unprocessable_entity
    end

  end
  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
    head :no_content
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
      raise ActiveRecordError::RecordNotFound if @region.blank? || !(@region.is_a? Region)
    end

    def set_job
      @job = Job.find params[:job_id]
    end

end
