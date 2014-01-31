require 'test_helper'

class ProductAreasControllerTest < ActionController::TestCase
  setup do
    @product_area = product_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_area" do
    assert_difference('ProductArea.count') do
      post :create, product_area: { name: @product_area.name }
    end

    assert_redirected_to product_area_path(assigns(:product_area))
  end

  test "should show product_area" do
    get :show, id: @product_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @product_area
    assert_response :success
  end

  test "should update product_area" do
    patch :update, id: @product_area, product_area: { name: @product_area.name }
    assert_redirected_to product_area_path(assigns(:product_area))
  end

  test "should destroy product_area" do
    assert_difference('ProductArea.count', -1) do
      delete :destroy, id: @product_area
    end

    assert_redirected_to product_areas_path
  end
end
