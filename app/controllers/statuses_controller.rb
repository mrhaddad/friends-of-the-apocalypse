class StatusesController < ApplicationController
  def new
    @status = Status.new
  end

  def create
    @status = Status.new(params[:status])
    if @status.save
      redirect_to root_path
    else
      render :new
    end
  end
end