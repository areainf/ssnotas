require 'test_helper'

class NotasTemporalesControllerTest < ActionController::TestCase
  setup do
    @nota_temporal = notas_temporales(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notas_temporales)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nota_temporal" do
    assert_difference('NotaTemporal.count') do
      post :create, nota_temporal: { cargado_por_id: @nota_temporal.cargado_por_id, codigo: @nota_temporal.codigo, descripcion: @nota_temporal.descripcion, destinatario: @nota_temporal.destinatario, destinatario_id: @nota_temporal.destinatario_id, estado: @nota_temporal.estado, fecha_carga: @nota_temporal.fecha_carga, fecha_nota: @nota_temporal.fecha_nota, nota_id: @nota_temporal.nota_id, remitente: @nota_temporal.remitente, remitente_id: @nota_temporal.remitente_id, tema: @nota_temporal.tema, tipo_nota_id: @nota_temporal.tipo_nota_id }
    end

    assert_redirected_to nota_temporal_path(assigns(:nota_temporal))
  end

  test "should show nota_temporal" do
    get :show, id: @nota_temporal
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nota_temporal
    assert_response :success
  end

  test "should update nota_temporal" do
    patch :update, id: @nota_temporal, nota_temporal: { cargado_por_id: @nota_temporal.cargado_por_id, codigo: @nota_temporal.codigo, descripcion: @nota_temporal.descripcion, destinatario: @nota_temporal.destinatario, destinatario_id: @nota_temporal.destinatario_id, estado: @nota_temporal.estado, fecha_carga: @nota_temporal.fecha_carga, fecha_nota: @nota_temporal.fecha_nota, nota_id: @nota_temporal.nota_id, remitente: @nota_temporal.remitente, remitente_id: @nota_temporal.remitente_id, tema: @nota_temporal.tema, tipo_nota_id: @nota_temporal.tipo_nota_id }
    assert_redirected_to nota_temporal_path(assigns(:nota_temporal))
  end

  test "should destroy nota_temporal" do
    assert_difference('NotaTemporal.count', -1) do
      delete :destroy, id: @nota_temporal
    end

    assert_redirected_to notas_temporales_path
  end
end
