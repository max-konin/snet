class NodesController < ApplicationController
  before_action :set_node, only: [:show, :edit, :update, :destroy]
  before_action :set_graph, only: [:index, :create]

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = @graph.nodes
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json { render json: @nodes, status: :ok }
    end
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json { render json: @node, status: :ok }
    end
  end

  # GET /nodes/new
  def new
    @node = Node.new
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json { render json: @node, status: :ok }
    end
  end

  # GET /nodes/1/edit
  def edit
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json { render json: @node, status: :ok }
    end
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = @graph.nodes.create! node_params

    respond_to do |format|
      if @node.save
        format.html { render status: :forbidden, text: 'Only json allowed'}
        format.json { render json: @node, status: :ok }
      else
        format.html { fail NotImplementedError }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { render status: :forbidden, text: 'Only json allowed'}
        format.json { head :no_content }
      else
        format.html { render status: :forbidden, text: 'Only json allowed'}
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    respond_to do |format|
      format.html { render status: :forbidden, text: 'Only json allowed'}
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_node
      @node = Node.find(params[:id])
    end

    def set_graph
      @graph = Graph.find params[:graph_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def node_params
      params.require(:node).permit :longitude, :latitude, :name
    end
end
