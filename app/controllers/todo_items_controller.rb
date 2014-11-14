class TodoItemsController < ApplicationController
  respond_to :json
  before_action :find_todo, only: [:show, :update, :destroy]


  def index
    @todo_items = TodoItem.all
    respond_with @todo_items
  end

  def show
    respond_with @todo_item
  end

  def new
    @todo_item = TodoItem.new
  end

  def edit
  end

  def create
    @todo_item = TodoItem.new(todo_params)

    if @todo_item.save
      respond_with @todo_item
    else
      render json: { errors: @todo_item.errors.full_messages }
    end
  end

  def update
    if @todo_item.update_attributes(todo_params)
      respond_with @todo_item
    else
      respond_with @todo_item.errors
    end
  end


  def destroy

    @todo_item.destroy
    render :nothing => true, :status => 204

  end

  private

    def find_todo
      @todo_item = TodoItem.find(params[:id])
    end

    def todo_params
      params.require(:todo_item).permit(:title, :done)
    end

end
