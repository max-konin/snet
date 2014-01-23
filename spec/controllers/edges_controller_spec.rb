require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe EdgesController do

  # This should return the minimal set of attributes required to create a valid
  # Edge. As you add validations to Edge, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { nodes: [@node_1, @node_2] } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EdgesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    @node_1 = FactoryGirl.create :node, name: 'node_1'
    @node_2 = FactoryGirl.create :node, name: 'node_2'
    @graph  = FactoryGirl.create :graph
    request.accept = 'application/json'
    sign_in FactoryGirl.create(:user)
  end

  describe "GET index" do
    it "assigns all edges in graph as @edges" do
      edge = @graph.edges.create! valid_attributes
      edge_out_of_graph = Edge.create! valid_attributes
      get :index, { graph_id: @graph.id }, valid_session
      assigns(:edges).should eq([edge])
    end
  end

  describe "GET show" do
    it "assigns the requested edge as @edge" do
      edge = @graph.edges.create! valid_attributes
      get :show, { graph_id: @graph.id, id: edge.to_param}, valid_session
      assigns(:edge).should eq(edge)
    end
  end

  describe "GET new" do
    it "assigns a new edge as @edge" do
      get :new, { graph_id: @graph.id }, valid_session
      assigns(:edge).should be_a_new(Edge)
    end
  end

  describe "GET edit" do
    it "assigns the requested edge as @edge" do
      edge = @graph.edges.create! valid_attributes
      get :edit, { graph_id: @graph.id, id: edge.to_param }, valid_session
      assigns(:edge).should eq(edge)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Edge" do
        expect {
          post :create, { graph_id: @graph.id, edge: valid_attributes }, valid_session
        }.to change(Edge, :count).by(1)
      end

      it "assigns a newly created edge as @edge" do
        post :create, { graph_id: @graph.id, edge: valid_attributes }, valid_session
        assigns(:edge).should be_a(Edge)
        assigns(:edge).should be_persisted
        assigns(:edge).should have(2).nodes
        @graph.reload.edges.should include assigns(:edge)
      end

      it "returns status created" do
        post :create, { graph_id: @graph.id, edge: valid_attributes }, valid_session
        response.status.should be 201
      end

      it 'adds nodes in the graph if they are not there' do
        node_1 = FactoryGirl.create :node
        node_2 = FactoryGirl.create :node
        @graph.nodes.should_not include(node_1, node_2)
        post :create, { graph_id: @graph.id, edge: { nodes: [node_1, node_2]  } }, valid_session
        @graph.reload
        @graph.nodes.should include(node_1, node_2)
      end
    end

  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested edge" do
        edge = @graph.edges.create! valid_attributes
        # Assuming there are no other edges in the database, this
        # specifies that the Edge created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Edge.any_instance.should_receive(:update).with({ 'name' => 'new_name'  })
        put :update, {graph_id: @graph.id, id: edge.to_param, edge: { 'name' => 'new_name' }}, valid_session
      end

      it "assigns the requested edge as @edge" do
        edge = @graph.edges.create! valid_attributes
        put :update, {graph_id: @graph.id, id: edge.to_param, edge: valid_attributes}, valid_session
        assigns(:edge).should eq(edge)
      end
    end

    describe "with invalid params" do
      #it "assigns the edge as @edge" do
      #  edge = Edge.create! valid_attributes
      #  # Trigger the behavior that occurs when invalid params are submitted
      #  Edge.any_instance.stub(:save).and_return(false)
      #  put :update, {:id => edge.to_param, :edge => {  }}, valid_session
      #  assigns(:edge).should eq(edge)
      #end
      #
      #it "re-renders the 'edit' template" do
      #  edge = Edge.create! valid_attributes
      #  # Trigger the behavior that occurs when invalid params are submitted
      #  Edge.any_instance.stub(:save).and_return(false)
      #  put :update, {:id => edge.to_param, :edge => {  }}, valid_session
      #  response.should render_template("edit")
      #end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested edge" do
      edge = @graph.edges.create! valid_attributes
      expect {
        delete :destroy, { graph_id: @graph.id, id: edge.to_param }, valid_session
      }.to change(Edge, :count).by(-1)
    end
  end

  describe "POST create and GET index" do
    it 'returns all edges in graph' do
      post :create, { graph_id: @graph.id, edge: valid_attributes }, valid_session
      edge = assigns :edge
      get :index, { graph_id: @graph.id }, valid_session
      assigns(:edges).should include edge
    end
  end
end
