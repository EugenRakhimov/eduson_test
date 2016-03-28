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
      exponat1, exponat2 = create(:exponat), create(:exponat)
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
        post :create, exponat: { link: exponat.link, item_type: exponat.item_type }
        expect(response).to have_http_status(302)
        expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
      end
       it "creates exponat if user is logged in" do
        exponat = create(:exponat)
        count_before = Exponat.count
        user = FactoryGirl.create(:user)
        sign_in :user, user
        post :create, exponat: { link: exponat.link, item_type: exponat.item_type }
        expect(count_before+1).to eq(Exponat.count)
       end 
    end

  describe "Edit exponat" do 
    it "redirects if you are not logged in" do
      get :edit, id:1
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
    end
    it "redirects if you are trying edit exponat of other user" do
      exponat = create(:exponat)
      user1 = exponat.user
      user2 = FactoryGirl.create(:user)
      sign_in :user, user2
      get :edit, id: exponat
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вы пытаетесь совершить деструктивные действия с чужим контентом")
    end
    it "gets you inside" do
      exponat = create(:exponat)
      user = exponat.user
      sign_in :user, user
      get :edit, id: exponat
      expect(response).to be_success
      expect(response).to have_http_status(200)
      expect(response).to render_template("edit")
    end
  end

  describe "update exponat" do
    it "don't allow to update if you are not logged in" do
      exponat = create(:exponat)
      patch :update, id: exponat, exponat: { link: exponat.link, item_type: exponat.item_type }
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
    end
    it "don't allow to update exponat of other user" do
      exponat = create(:exponat)
      user1 = exponat.user
      user2 = FactoryGirl.create(:user)
      sign_in :user, user2
      patch :update, id: exponat, exponat: { link: exponat.link, item_type: exponat.item_type }
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вы пытаетесь совершить деструктивные действия с чужим контентом")
    end
    it "updates item if you are logged in and you are an owner" do
      exponat = create(:exponat)
      user = exponat.user
      sign_in :user, user
      patch :update, id: exponat, exponat: { link: "http://stackoverflow.com/", item_type: 6 }
      exponat = Exponat.first
      expect(exponat.link).to eq("http://stackoverflow.com/")
      expect(exponat.item_type).to eq(6)
    end
  end

  describe "delete exponat" do
    it "don't allow to delete if you are not logged in" do
      exponat = create(:exponat)
      delete :destroy, id: exponat
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вам необходимо войти в систему или зарегистрироваться.")
    end
    it "don't allow to delete exponat of other user" do
      exponat = create(:exponat)
      user1 = exponat.user
      user2 = FactoryGirl.create(:user)
      sign_in :user, user2
      delete :destroy, id: exponat
      expect(response).to have_http_status(302)
      expect(response.request.flash["alert"]).to include("Вы пытаетесь совершить деструктивные действия с чужим контентом")
    end
    it "deletes item if you are logged in and you are an owner" do
      exponat = create(:exponat)
      user = exponat.user
      sign_in :user, user
      delete :destroy, id: exponat
      expect(Exponat.count).to eq(0)
    end
  end
end
end
