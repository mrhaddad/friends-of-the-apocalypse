class WelcomeController < ApplicationController
  def index
    @statuses = Status.order("created_at desc").first(10)
  end
end