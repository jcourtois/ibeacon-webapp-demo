require 'test_helper'

class VisitsControllerTest < ActionController::TestCase
  setup do
    require 'pry'
    @visit = visits(:one)
  end

  test "should get index" do
    get :index, use_route: :customer_visits, customer_id: customers(:one).id
    assert_response :success
    assert_not_nil assigns(:visits)
  end

  test "should get new" do
    get :new, use_route: :new_customer_visit, customer_id: customers(:one).id
    assert_response :success
  end

  test "should create visit" do
    assert_difference('Visit.count') do
      post :create,
           visit: { customer_id: @visit.customer_id, enter_time: @visit.enter_time, exit_time: @visit.exit_time },
           use_route: :customer, id: @visit, customer_id: @visit.customer_id
    end

    assert_redirected_to customer_visit_path(assigns(:visit))
  end

  test "should show visit" do
    get :show, use_route: :customer_visit, id: @visit, customer_id: customers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, use_route: :edit_customer_visit, id: @visit, customer_id: customers(:one).id
    assert_response :success
  end

  test "should update visit" do
    patch :update, { :id => @visit.id, :customer_id => @visit.customer_id, visit: { enter_time: @visit.enter_time, exit_time: @visit.exit_time } }, use_route: :customer_visit
    assert_redirected_to customer_visit_path(assigns(:visit))
  end

  test "should destroy visit" do
    assert_difference('Visit.count', -1) do
      delete :destroy, use_route: :customer_visit, id: @visit, customer_id: customers(:one).id
    end

    assert_redirected_to customer_visits_path
  end
end
