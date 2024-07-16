class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def approve
    update(status: "Approved")
  end
end