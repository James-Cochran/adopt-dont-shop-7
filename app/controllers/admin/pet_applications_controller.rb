class Admin::PetApplicationsController < ApplicationController

  def update
    # binding.pry
    @pet_application = PetApplication.find_by(application_id: params[:id],
                                              pet_id: params[:pet_id])
    # binding.pry
    if params["status" => "Approved"].present?
      @pet_application.status.update("status" => "Approved")
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end