class ExponatsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create,:edit, :update, :destroy]
  before_action :set_exponat, only: [:show, :edit, :update, :destroy]
  before_action :check_rights, only: [:edit, :update, :destroy]


  # GET /exponats
  # GET /exponats.json
  def index
    @exponats = Exponat.all
  end

  # GET /exponats/1
  # GET /exponats/1.json
  def show
  end

  # GET /exponats/new
  def new
    @exponat = Exponat.new
  end

  # GET /exponats/1/edit
  def edit
  end

  # POST /exponats
  # POST /exponats.json
  def create
    @exponat = current_user.exponats.new(exponat_params)
    # Exponat.new(exponat_params)

    respond_to do |format|
      if @exponat.save
        format.html { redirect_to @exponat, notice: 'Exponat was successfully created.' }
        format.json { render :show, status: :created, location: @exponat }
      else
        format.html { render :new }
        format.json { render json: @exponat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /exponats/1
  # PATCH/PUT /exponats/1.json
  def update
    respond_to do |format|
      if @exponat.update(exponat_params)
        format.html { redirect_to @exponat, notice: 'Exponat was successfully updated.' }
        format.json { render :show, status: :ok, location: @exponat }
      else
        format.html { render :edit }
        format.json { render json: @exponat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exponats/1
  # DELETE /exponats/1.json
  def destroy
    @exponat.destroy
    respond_to do |format|
      format.html { redirect_to exponats_url, notice: 'Вы удалили элемент из медиа-коллекции' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exponat
      @exponat = Exponat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exponat_params
      params.require(:exponat).permit(:link, :item_type)
    end

    def check_rights
      if @exponat.user != current_user  
        respond_to do |format|
          format.html { redirect_to root_url, alert: 'Вы пытаетесь совершить деструктивные действия с чужим контентом' }
          format.json { head :no_content }
        end
      end    
    end
end
