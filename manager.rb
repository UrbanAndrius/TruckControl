# gives and manages tasks for drivers
class Manager
  attr_reader :drivers
  def initialize
    @drivers = []
  end

  def add_driver(driver)
    drivers.push(driver)
  end

  def assign_task(task, driver_pos)
    drivers[driver_pos].task = task
  end

  def create_task_with_route(route, driver_pos)
    driver = drivers[driver_pos]
    task = Task.new
    task.route = route
    driver.task = task
  end

  def assign_truck(truck, driver_pos)
    drivers[driver_pos].truck = truck
  end

  def send_message(message, driver_pos)
    drivers[driver_pos].add_message(message)
  end

  def send_file(file_name, driver_pos)
    drivers[driver_pos].add_file(file_name)
  end

  def driver_info(driver_pos)
    drivers[driver_pos].info
  end

  def truck_info(driver_pos)
    drivers[driver_pos].truck.info
  end

  def tasks_status
    result = ''
    drivers.each { |driver| result += driver.task.status }
    result
  end
end
