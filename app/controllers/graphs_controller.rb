class GraphsController < ApplicationController
  before_action :set_graph, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  include OnlyJsonResponse

  # GET /graphs
  # GET /graphs.json
  def index
    @graphs = Graph.all
  end

  # GET /graphs/1
  # GET /graphs/1.json
  def show
  end

  # GET /graphs/new
  def new
    @graph = Graph.new
  end

  # GET /graphs/1/edit
  def edit
  end

  # POST /graphs
  # POST /graphs.json
  def create
    @graph = Graph.new(graph_params)

    respond_to do |format|
      if @graph.save
        format.html { redirect_to @graph, notice: 'Graph was successfully created.' }
        format.json { render action: 'show', status: :created, location: @graph }
      else
        format.html { render action: 'new' }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /graphs/1
  # PATCH/PUT /graphs/1.json
  def update
    respond_to do |format|
      if @graph.update(graph_params)
        format.html { redirect_to @graph, notice: 'Graph was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @graph.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /graphs/1
  # DELETE /graphs/1.json
  def destroy
    @graph.destroy
    respond_to do |format|
      format.html { redirect_to graphs_url }
      format.json { head :no_content }
    end
  end

  def get_mst
    build_graph
    @mst = @graph.get_mst
    create_response { render json: @mst.edges.to_json(include: :nodes), status: :ok }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_graph
      @graph = Graph.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def graph_params
      params[:graph].blank? ? nil : params.require(:graph).permit(:name)
    end

    def build_graph
      @graph = Graph.new nodes: [], edges: []
      edges = params[:edges]
      edges.each do |e|
        nodes = []
        e[:nodes].each do |n|
          node = (@graph.nodes
                        .select{|node| (node.latitude == n[:latitude].to_f) && (node.longitude == n[:longitude].to_f)})
                        .first
          if node.nil?
            node = Node.new(n)
            @graph.nodes << node
          end
          nodes << node
        end
        edge = Edge.new nodes: nodes, weight: e[:weight].to_i
        @graph.edges << edge
      end
    end
end
