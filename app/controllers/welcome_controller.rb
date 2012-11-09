class WelcomeController < ApplicationController
  def index
    @statuses = Status.visible.order("created_at desc")
  end
end