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

describe NodesController do

  # This should return the minimal set of attributes required to create a valid
  # Node. As you add validations to Node, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { latitude: 0, longitude: 0 } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # NodesController. Be sure to keep this updated too.
  let(:valid_session) { {} }


  before :each do
    @graph = FactoryGirl.create :graph
    @node = @graph.nodes.create! valid_attributes
    request.accept = 'application/json'
    sign_in FactoryGirl.create(:user)
  end

  describe "GET index" do
    it "assigns all nodes as @nodes" do
      get :index, {graph_id: @graph.id}, valid_session
      assigns(:nodes).should eq([@node])
    end
  end

  describe "GET show" do
    it "assigns the requested node as @node" do
      get :show, {graph_id: @graph.id, :id => @node.to_param}, valid_session
      assigns(:node).should eq(@node)
    end
  end

  describe "GET edit" do
    it "assigns the requested node as @node" do
      request.accept = 'application/html'
      get :edit, {graph_id: @graph.id, :id => @node.to_param}, valid_session
      assigns(:node).should eq(@node)
    end
  end


  describe "GET new" do
    it "assigns a new node as @node" do
      get :new, {graph_id: @graph.id}, valid_session
      assigns(:node).should be_a_new(Node)
    end
  end


  describe "POST create" do
    describe "with valid params" do
      it "creates a new Node" do
        expect {
          post :create, {graph_id: @graph.id, :node => valid_attributes}, valid_session
        }.to change(Node, :count).by(1)
      end

      it "assigns a newly created node as @node" do
        post :create, {graph_id: @graph.id, :node => valid_attributes}, valid_session
        assigns(:node).should be_a(Node)
        assigns(:node).should be_persisted
      end

      it "return status ok" do
        post :create, {graph_id: @graph.id, :node => valid_attributes}, valid_session
        response.status.should be 200
      end
    end
  end

  describe 'DELETE destroy' do
    it 'destroy the node' do
      expect {
        delete :destroy, {graph_id: @graph, id: @node}
      }.to change(Node, :count).by(-1)
    end
  end


end
