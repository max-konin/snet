class RegionsController < ApplicationController
  before_action :set_job
  before_action :set_region, only: [:show, :edit, :update, :destroy]
  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new
    params[:region][:points].each { |p| @region.points.build p}
    respond_to do |format|
      if @region.save
        format.html { redirect_to [@job, @region], notice: 'Region was successfully created.' }
        format.json { render action: 'show', status: :created, location: [@job, @region] }
      else
        format.html { render action: 'new' }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1
  # PATCH/PUT /regions/1.json
  def update
    @region.points.destroy_all
    respond_to do |format|
      if @region.save
        format.html { redirect_to [@job, @region], notice: 'Region was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region.destroy
    respond_to do |format|
      format.html { redirect_to job_region_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    def set_job
      @job = Job.find params[:job_id]
    end

end
