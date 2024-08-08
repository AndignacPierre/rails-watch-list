class ListsController < ApplicationController
  def index
    @lists = List.new
  end

  def show
    @list = List.all
  end
end
