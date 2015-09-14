
class BirdsController < ApplicationController
  include BirdsHelper
  before_action :set_bird, only: [:show, :destroy]
  before_action :read_json, only: [:create]
  skip_before_action :verify_authenticity_token

  # GET /birds
  # GET /birds.json
  def index
    @birds = Bird.all
    respond_to do |format|
      format.json { render json: get_birds_response(@birds), status: :ok }   # Method available in birds_helper.rb
    end
  end

  # GET /birds/1
  # GET /birds/1.json
  def show
    if @bird
    respond_to do |format|
      format.json { render json: @bird.get_bird_response("GET"), status: :ok}  # Model Methods
    end
  else
    respond_to do |format|
      format.json { render json: { "error" => "Bird with given id not found"}, status: :not_found}
    end
  end
  end

  # POST /birds
  # POST /birds.json
  def create

    @bird = Bird.new
    @bird.name = @json["required"][0]["name"]
    @bird.family = @json["required"][1]["family"]
    @bird.continents = @json["required"][2]["continents"] 
    @bird.visible =   @json["required"][3]["visible"]  if @json["required"][3].present?

    respond_to do |format|
      if @bird.save
        format.json { render json: @bird.get_bird_response("POST"), status: :created }
      else
        format.json { render json: @bird.errors.to_json, status: :bad_request }
      end
    end
  end
  # DELETE /birds/1
  # DELETE /birds/1.json
  def destroy
    if @bird
      @bird.destroy
      respond_to do |format|
        format.json { render nothing: true, status: :ok}
      end
    else 
      respond_to do |format|
        format.json { render nothing: true, status: :not_found}
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bird
      @bird = Bird.find(params[:id])
    end
    def read_json
      @json = JSON.parse(request.body.read)
      render json: {"error" => "Empty body sent"}, status: :bad_request if @json.blank?
    end
end
