class ProductAreasController < ApplicationController
  before_action :set_product_area, only: [:show, :edit, :update, :destroy]

  def index
    @product_areas = ProductArea.all
  end

  def show
  end

  def new
    @product_area = ProductArea.new
  end

  def edit
  end

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

  def destroy
    @product_area.destroy
    respond_to do |format|
      format.html { redirect_to product_areas_url }
      format.json { head :no_content }
    end
  end

  private
    def set_product_area
      @product_area = ProductArea.find(params[:id])
    end

    def product_area_params
      params.require(:product_area).permit(:name)
    end
end
