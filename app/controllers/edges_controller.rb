class EdgesController < ApplicationController

  include OnlyJsonResponse

  before_action :set_graph
  before_action :set_edge, only: [:show, :edit, :update, :destroy]

  # GET /edges
  # GET /edges.json
  def index
    @edges = @graph.edges.all
    create_response { render json: @edges, status: :ok }
  end

  # GET /edges/1
  # GET /edges/1.json
  def show
    create_response { render json: @edge, status: :ok }
  end

  # GET /edges/new
  def new
    @edge = @graph.edges.build
    create_response { render json: @edge, status: :ok }
  end

  # GET /edges/1/edit
  def edit
    create_response { render json: @edge, status: :ok }
  end

  # POST /edges
  # POST /edges.json
  def create
    @edge = Edge.new(edge_params)
    if @edge.save
      create_response { render json: @edge, status: :created }
    else
      create_response { render json: @edge.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /edges/1
  # PATCH/PUT /edges/1.json
  def update
    if @edge.update(edge_params)
      create_response { head :no_content }
    else
      create_response { render json: @edge.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /edges/1
  # DELETE /edges/1.json
  def destroy
    @edge.destroy
    create_response { head :no_content }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_edge
      @edge = @graph.edges.find params[:id]
    end

    def set_graph
      @graph = Graph.find params[:graph_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edge_params
      params.require(:edge).permit :nodes, :name
    end

end
