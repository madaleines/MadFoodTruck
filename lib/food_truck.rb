class FoodTruck
  attr_reader :name, :address
  
  def initialize(input)
    @name = input[:name]
    @address = input[:address]
  end
end
