class Admin::PetApplicationsController < ApplicationController

  def update
    # binding.pry
    @pet_application = PetApplication.find(params[:id])
    # binding.pry
    if params["status"=>"Approved"].present?
      @pet_application.approve
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end