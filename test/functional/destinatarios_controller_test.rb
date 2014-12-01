require 'test_helper'

class DestinatariosControllerTest < ActionController::TestCase
  setup do
    @destinatario = destinatarios(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:destinatarios)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create destinatario" do
    assert_difference('Destinatario.count') do
      post :create, destinatario: { apellido: @destinatario.apellido, autoridad_id: @destinatario.autoridad_id, descripcion: @destinatario.descripcion, es_autoridad_actual: @destinatario.es_autoridad_actual, nombre: @destinatario.nombre }
    end

    assert_redirected_to destinatario_path(assigns(:destinatario))
  end

  test "should show destinatario" do
    get :show, id: @destinatario
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @destinatario
    assert_response :success
  end

  test "should update destinatario" do
    put :update, id: @destinatario, destinatario: { apellido: @destinatario.apellido, autoridad_id: @destinatario.autoridad_id, descripcion: @destinatario.descripcion, es_autoridad_actual: @destinatario.es_autoridad_actual, nombre: @destinatario.nombre }
    assert_redirected_to destinatario_path(assigns(:destinatario))
  end

  test "should destroy destinatario" do
    assert_difference('Destinatario.count', -1) do
      delete :destroy, id: @destinatario
    end

    assert_redirected_to destinatarios_path
  end
end
