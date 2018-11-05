# information for driver what to do
class Task
  attr_reader :status, :route, :title
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
    @title = title unless title.to_s.empty?
  end
end
