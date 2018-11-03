# driver uses truck to complete tasks
class Truck
  def initialize
    @plate_number = ''
  end

  def info
    "Number: #{@plate_number}"
  end

  def plate_number=(number)
    @plate_number = number unless number.to_s.empty?
  end
end
