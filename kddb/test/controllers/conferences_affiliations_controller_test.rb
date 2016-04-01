require 'test_helper'

class ConferencesAffiliationsControllerTest < ActionController::TestCase
  setup do
    @conferences_affiliation = conferences_affiliations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:conferences_affiliations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create conferences_affiliation" do
    assert_difference('ConferencesAffiliation.count') do
      post :create, conferences_affiliation: {  }
    end

    assert_redirected_to conferences_affiliation_path(assigns(:conferences_affiliation))
  end

  test "should show conferences_affiliation" do
    get :show, id: @conferences_affiliation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @conferences_affiliation
    assert_response :success
  end

  test "should update conferences_affiliation" do
    patch :update, id: @conferences_affiliation, conferences_affiliation: {  }
    assert_redirected_to conferences_affiliation_path(assigns(:conferences_affiliation))
  end

  test "should destroy conferences_affiliation" do
    assert_difference('ConferencesAffiliation.count', -1) do
      delete :destroy, id: @conferences_affiliation
    end

    assert_redirected_to conferences_affiliations_path
  end
end
