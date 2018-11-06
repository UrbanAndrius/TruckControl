require 'rspec'
require 'simplecov'
SimpleCov.start

require_relative 'manager'
require_relative 'driver'
require_relative 'task'
require_relative 'route'
require_relative 'truck'

require_relative 'driver_spec'
require_relative 'task_spec'
require_relative 'controller_spec'

describe('Manager') do
  it 'should see all drivers' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.add_driver(Driver.new)
    drivers = manager.drivers
    expect(drivers.size).to eql(2)
  end

  it 'should assign task to driver' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.assign_task(Task.new, 0)
    driver = manager.drivers[0]
    expect(driver.task).not_to eql(nil)
  end

  it 'should create route for task' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.create_task_with_route(Route.new, 0)
    expect(manager.drivers[0].task).not_to eql(nil)
  end
end

describe('Manager') do
  it 'should assign truck to driver' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.assign_truck(Truck.new, 0)
    driver = manager.drivers[0]
    expect(driver.truck).not_to eql(nil)
  end

  it 'should send message to driver' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.send_message('hello', 0)
    driver = manager.drivers[0]
    expect(driver.messages[0]).to eql('hello')
  end

  it 'should see information of the driver' do
    manager = Manager.new
    driver = Driver.new
    driver.name = 'John'
    manager.add_driver(driver)
    info = manager.driver_info(0)
    expect(info).to include('John')
  end
end

describe('Manager') do
  it 'should see information of truck' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    truck = Truck.new
    truck.plate_number = 'XYZ 123'
    manager.assign_truck(truck, 0)
    expect(manager.truck_info(0)).to include('XYZ')
  end

  it 'should see status of assigned tasks' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.assign_task(Task.new, 0)
    task = Task.new
    task.status = 'started'
    manager.add_driver(Driver.new)
    manager.assign_task(task, 1)
    expect(manager.tasks_status).to include('new', 'started')
  end
end

describe('Manager') do
  it 'should send files to driver' do
    manager = Manager.new
    manager.add_driver(Driver.new)
    manager.send_file('test_file.txt', 0)
    driver = manager.drivers[0]
    expect(driver.files[0]).to eql('test_file.txt')
  end

  it 'should have driver list' do
    manager = Manager.new
    driver1 = Driver.new
    driver2 = Driver.new
    manager.add_driver(driver1)
    manager.add_driver(driver2)
    expect(manager.drivers).to match_array([driver1, driver2])
  end
end
