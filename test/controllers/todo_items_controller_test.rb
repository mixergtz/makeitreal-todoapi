require 'test_helper'

class TodoItemsControllerTest < ActionController::TestCase

  def setup
    @todo = todo_items(:one)
  end

  test "index should return a list of items" do
    get :index, format: :json
    assert_response :success
  end

  test "show should return the item requested" do
    get :show, id: @todo.id, format: :json
    assert @todo
  end

  test "create should increase todo_item" do
    assert_difference('TodoItem.count', +1) do
      post :create, todo_item: { title: 'Some title' }, format: :json
    end
  end

  test "delete should decrease todo_item" do
    assert_difference('TodoItem.count', -1) do
      delete :destroy, id:@todo.id
    end
  end

  test "update should change updated at" do
    patch :update, id: @todo.id, todo_item: { done: true }, format: :json
    assert_not_same( false, @todo.reload.done, "Done attribute should have changed" )
  end

  test "create with no params should raise error" do
    assert_raise ActionController::ParameterMissing do
      post :create, todo_item: { }, format: :json
    end
  end

  test "create with a lot of wrong params should create objects" do
    assert_no_difference('TodoItem.count') do
      post :create, todo_item: { some: "algo", algo: "123123", otro: "eawera" }, format: :json
    end

  end

  test "delete with wrong id should raise record not found" do
    assert_raise ActiveRecord::RecordNotFound do
      delete :destroy, id: "as"
    end
  end

  test "update with wrong id should raise record not found" do
    assert_raise ActiveRecord::RecordNotFound do
      patch :update, id: "as", todo_item: { done: true }, format: :json
    end
  end

  test "update with correct id but wrong params should not update object" do
    patch :update, id: @todo.id, todo_item: { some: "algo", algo: "123123", otro: "eawera" }, format: :json
    assert_same( @todo, @todo.reload, "Must be the same object" )
  end

  test "show should return record not found with wrong id" do
    assert_raise ActiveRecord::RecordNotFound do
      get :show, id: "dafadf", format: :json
    end
  end


end
