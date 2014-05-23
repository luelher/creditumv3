class DashboardController < ApplicationController
  authorize_resource class: DashboardController
  before_action :authenticate_user!

  def index
  end
  
end
