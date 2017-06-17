class Transaction < ApplicationRecord
  
  # Type of Vehicles the car wash can wash
  VEHICLES = %w(Car Truck)
  
  # validations
  validates :license_plate, presence: true
  validates :vehicle_type, :inclusion=> { :in => VEHICLES }

  # things that price and transaction are based on.
  attr_accessor :bed_down, :mud_in_bed, :vehicle_type
  
  default_scope { order(created_at: :desc) }

end
