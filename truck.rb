# driver uses truck to complete tasks
class Truck
  attr_reader :plate_number
  def initialize
    @plate_number = 'XYZ'
  end

  def plate_number=(number)
    @plate_number = number unless number.to_s.empty?
  end
end
