require 'test_helper'

class AutoridadesControllerTest < ActionController::TestCase
  setup do
    @autoridad = autoridades(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:autoridades)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create autoridad" do
    assert_difference('Autoridad.count') do
      post :create, autoridad: { cargo: @autoridad.cargo, descripcion: @autoridad.descripcion }
    end

    assert_redirected_to autoridad_path(assigns(:autoridad))
  end

  test "should show autoridad" do
    get :show, id: @autoridad
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @autoridad
    assert_response :success
  end

  test "should update autoridad" do
    put :update, id: @autoridad, autoridad: { cargo: @autoridad.cargo, descripcion: @autoridad.descripcion }
    assert_redirected_to autoridad_path(assigns(:autoridad))
  end

  test "should destroy autoridad" do
    assert_difference('Autoridad.count', -1) do
      delete :destroy, id: @autoridad
    end

    assert_redirected_to autoridades_path
  end
end
