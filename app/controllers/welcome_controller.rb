class WelcomeController < ApplicationController
  def index
    @statuses = Status.order("created_at desc")
  end
end