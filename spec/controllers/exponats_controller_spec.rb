require 'rails_helper'
require 'devise'


RSpec.describe ExponatsController, :type => :controller do
  
  setup do
    @exponat = exponats(:one)
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end

    it "loads all of the gallery items into @exponats" do
      exponat1, exponat2 = Exponat.create!, Exponat.create!
      get :index

      expect(assigns(:exponats)).to match_array([exponat1, exponat2])
    end
  end

  describe "Get #new" do
    it "responds with notice if user is not logged in" do 
      get :new
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
    end
    it "allows logged user to open new form" do 
      user = FactoryGirl.create(:user)
      sign_in :user, user
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end

    describe "Create exponat" do       
      it "redirects to home if user is not logged in " do
        exponat = create(:exponat)
        post :create, exponat: { link: exponat.link, link_type: exponat.item_type }
        expect(response).to have_http_status(302)
        expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
      end
       it "creates exponat if user is logged in" do
        exponat = create(:exponat)
        count_before = Exponat.count
        user = FactoryGirl.create(:user)
        sign_in :user, user
        post :create, exponat: { link: exponat.link, link_type: exponat.item_type }
        expect(count_before+1).to eq(Exponat.count)
       end 
    end

    describe "Show exponat"
  end

  # test "should show exponat" do
  #   get :show, id: @exponat
  #   assert_response :success
  # end

  # test "should get edit" do
  #   get :edit, id: @exponat
  #   assert_response :success
  # end

  # test "should update exponat" do
  #   patch :update, id: @exponat, exponat: { link: @exponat.link, link_type: @exponat.link_type }
  #   assert_redirected_to exponat_path(assigns(:exponat))
  # end

  # test "should destroy exponat" do
  #   assert_difference('Exponat.count', -1) do
  #     delete :destroy, id: @exponat
  #   end

  #   assert_redirected_to exponats_path
  # end
end
