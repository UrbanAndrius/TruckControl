# information for driver what to do
class Task
  attr_reader :status
  def initialize
    @title = 'no title'
    @status = 'new'
  end

  def route=(route)
    @route = route if route.is_a?(Route)
  end

  def status=(status)
    @status = status unless status.to_s.empty?
  end

  def title=(title)
    @title = title unless status.to_s.empty?
  end
end
