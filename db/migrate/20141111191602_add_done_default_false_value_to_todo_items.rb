class AddDoneDefaultFalseValueToTodoItems < ActiveRecord::Migration
  def change
    change_column :todo_items, :done, :boolean, default: false
  end
end
