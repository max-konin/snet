class NodesController < ApplicationController
  before_filter :authenticate_user!

  include OnlyJsonResponse

  before_action :set_node, only: [:show, :edit, :update, :destroy]
  before_action :set_graph

  # GET /nodes
  # GET /nodes.json
  def index
    @nodes = @graph.nodes
    create_response { render json: @nodes, status: :ok }
  end

  # GET /nodes/1
  # GET /nodes/1.json
  def show
    create_response { render json: @node, status: :ok }
  end

  # GET /nodes/new
  def new
    @node = Node.new
    create_response { render json: @node, status: :ok }
  end

  # GET /nodes/1/edit
  def edit
  end

  # POST /nodes
  # POST /nodes.json
  def create
    @node = @graph.nodes.create! node_params
    if @node.save
      create_response { render json: @node, status: :ok }
    else
      create_response { render json: @node.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /nodes/1
  # PATCH/PUT /nodes/1.json
  def update
    respond_to do |format|
      if @node.update(node_params)
        format.html { redirect_to @graph }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @node.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nodes/1
  # DELETE /nodes/1.json
  def destroy
    @node.destroy
    create_response { head :no_content }
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
