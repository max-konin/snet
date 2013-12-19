class EdgesController < ApplicationController

  include OnlyJsonResponse

  before_action :set_graph
  before_action :set_edge, only: [:show, :edit, :update, :destroy]
  before_action :add_joined_node_to_graph, only: [:create, :update]

  # GET /edges
  # GET /edges.json
  def index
    @edges = @graph.edges.all
    create_response { render json: @edges.to_json(include: :nodes), status: :ok }
  end

  # GET /edges/1
  # GET /edges/1.json
  def show
    create_response { render json: @edge.to_json(include: :nodes), status: :ok }
  end

  # GET /edges/new
  def new
    @edge = @graph.edges.build
    create_response { render json: @edge.to_json(include: :nodes), status: :ok }
  end

  # GET /edges/1/edit
  def edit
    create_response { render json: @edge.to_json(include: :nodes), status: :ok }
  end

  # POST /edges
  # POST /edges.json
  def create
    @edge = @graph.edges.build(edge_params)
    @graph.edges << @edge
    if @edge.save && add_nodes_to_edge(@edge) && @graph.save
      create_response { render json: @edge.to_json(include: :nodes), status: :created }
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

    def add_nodes_to_edge(edge)
      params[:edge][:nodes].each do |node|
        edge.nodes << Node.find(node)
      end
      edge.save
    end

    def set_graph
      @graph = Graph.find params[:graph_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def edge_params
      params.require(:edge).permit :name
    end

    def add_joined_node_to_graph
      unless params[:edge][:nodes].nil?
        params[:edge][:nodes].each do |node|
          @graph.nodes << Node.find(node) unless @graph.nodes.include? Node.find(node)
        end
        @graph.save!
      end
    end

end
