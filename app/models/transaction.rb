class Transaction < ApplicationRecord
  
  # Type of Vehicles the car wash can wash
  VEHICLES = %w(Car Truck)
  
  # validations
  validates :license_plate, presence: true
  validates :vehicle_type, :inclusion=> { :in => VEHICLES }
  
  # custom validate
  validate :not_stolen
  validate :bed_not_down
  validate :fair_price
  
  # set our price
  before_create :fair_price
  
  
  # things that price and transaction are based on.
  attr_accessor :bed_is_down, :mud_in_bed, :vehicle_type
  
  default_scope { order(created_at: :desc) }
  scope :license_count, lambda { |l| where(:license_plate => l).count }
    
    
  def fair_price
    cost = 5.00
    
    if(vehicle_type.eql?("Truck") && mud_in_bed.eql?("1"))
      cost = 12.00
    elsif(vehicle_type.eql?("Truck"))
      cost = 10.00
    end
    if(Transaction.license_count(license_plate) == 1) 
      cost = cost/2.0
    end

    write_attribute(:cost, cost)
  end

  protected
    def not_stolen
      self.errors.add(:license_plate, "This vehicle is stolen!") if license_plate.eql?("AA")
    end
    
    def bed_not_down
      self.errors.add(:bed_is_down, "The truck must have its bed up!") if bed_is_down.eql?("1") && vehicle_type.eql?("Truck")
    end
  
end
