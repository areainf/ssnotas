require 'test_helper'

class EstadosNotaControllerTest < ActionController::TestCase
  setup do
    @estado_nota = estados_nota(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:estados_nota)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create estado_nota" do
    assert_difference('EstadoNota.count') do
      post :create, estado_nota: { descripcion: @estado_nota.descripcion, nombre: @estado_nota.nombre }
    end

    assert_redirected_to estado_nota_path(assigns(:estado_nota))
  end

  test "should show estado_nota" do
    get :show, id: @estado_nota
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @estado_nota
    assert_response :success
  end

  test "should update estado_nota" do
    patch :update, id: @estado_nota, estado_nota: { descripcion: @estado_nota.descripcion, nombre: @estado_nota.nombre }
    assert_redirected_to estado_nota_path(assigns(:estado_nota))
  end

  test "should destroy estado_nota" do
    assert_difference('EstadoNota.count', -1) do
      delete :destroy, id: @estado_nota
    end

    assert_redirected_to estados_nota_path
  end
end
