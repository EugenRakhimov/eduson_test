require 'rails_helper'


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
      expect(controller).to set_flash[:alert].to("Вам необходимо войти в систему или зарегистрироваться.")
    end
  end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create exponat" do
  #   assert_difference('Exponat.count') do
  #     post :create, exponat: { link: @exponat.link, link_type: @exponat.link_type }
  #   end

  #   assert_redirected_to exponat_path(assigns(:exponat))
  # end

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
