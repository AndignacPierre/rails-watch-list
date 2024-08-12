class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    list_find
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    @list.save

    redirect_to list_path(@list)
  end

  def edit
    list_find
  end

  def update
    list_find
    if @list.update(list_params)
      redirect_to list_path(@list)
    else
      render :edit
    end
  end

  def destroy
    list_find
    @list.destroy

    redirect_to lists_path
  end

  private

  def list_params
    params.require(:list).permit(:name, :title, :photo)
  end

  def list_find
    @list = List.find(params[:id])
  end
end
