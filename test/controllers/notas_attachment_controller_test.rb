require 'test_helper'

class NotasAttachmentControllerTest < ActionController::TestCase
  setup do
    @nota_attachment = notas_attachment(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:notas_attachment)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create nota_attachment" do
    assert_difference('NotaAttachment.count') do
      post :create, nota_attachment: { filescan: @nota_attachment.filescan, nota_id: @nota_attachment.nota_id }
    end

    assert_redirected_to nota_attachment_path(assigns(:nota_attachment))
  end

  test "should show nota_attachment" do
    get :show, id: @nota_attachment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @nota_attachment
    assert_response :success
  end

  test "should update nota_attachment" do
    patch :update, id: @nota_attachment, nota_attachment: { filescan: @nota_attachment.filescan, nota_id: @nota_attachment.nota_id }
    assert_redirected_to nota_attachment_path(assigns(:nota_attachment))
  end

  test "should destroy nota_attachment" do
    assert_difference('NotaAttachment.count', -1) do
      delete :destroy, id: @nota_attachment
    end

    assert_redirected_to notas_attachment_path
  end
end
