class ProductAreasController < ApplicationController
  before_action :set_product_area, only: [:show, :edit, :update, :destroy]

  # GET /product_areas
  # GET /product_areas.json
  def index
    @product_areas = ProductArea.all
  end

  # GET /product_areas/1
  # GET /product_areas/1.json
  def show
  end

  # GET /product_areas/new
  def new
    @product_area = ProductArea.new
  end

  # GET /product_areas/1/edit
  def edit
  end

  # POST /product_areas
  # POST /product_areas.json
  def create
    @product_area = ProductArea.new(product_area_params)

    respond_to do |format|
      if @product_area.save
        format.html { redirect_to @product_area, notice: 'Product area was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product_area }
      else
        format.html { render action: 'new' }
        format.json { render json: @product_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_areas/1
  # PATCH/PUT /product_areas/1.json
  def update
    respond_to do |format|
      if @product_area.update(product_area_params)
        format.html { redirect_to @product_area, notice: 'Product area was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_areas/1
  # DELETE /product_areas/1.json
  def destroy
    @product_area.destroy
    respond_to do |format|
      format.html { redirect_to product_areas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_area
      @product_area = ProductArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_area_params
      params.require(:product_area).permit(:name)
    end
end
