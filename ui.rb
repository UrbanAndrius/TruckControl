require_relative 'driver'
require_relative 'task'
require_relative 'truck'
require_relative 'controller'

Shoes.app do

  @login_controller = Controller.new

  layout = stack do
    button 'start' do
      layout.clear {}
      login
    end
  end

  def login
    layout = stack do
      para 'Please enter username and password'
      user = edit_line
      password = edit_line
      button 'Login' do
        if @login_controller.check_input(user.text, password.text)
          layout.clear {}
          login_manager(user.text)
        else
          alert 'Wrong username or password'
        end
      end
      button 'Create new account' do
        layout.clear {}
        create_new
      end
    end
  end

  def create_new
    layout = stack do
      button 'Back' do
        layout.clear {}
        login
      end
      para 'Enter username and password'
      user = edit_line
      password = edit_line
      button 'Create account' do
        if @login_controller.check_exists(user.text)
          alert 'Username already exists'
        else
          @login_controller.save_new_account(user.text, password.text)
          layout.clear {}
          login
          alert 'Account created'
        end
      end
    end
  end

  def login_manager(username)
    layout = stack do
      para 'Drivers'
      drivers = @login_controller.load_driver_list(username)
      drivers.each do |driver|
        button "#{driver.name}" do
          layout.clear {}
          show_driver(username, driver)
        end
      end
      button 'add driver' do
        add_driver(username)
      end
      button 'logout' do
        layout.clear {}
        login
      end
    end
  end

  def show_driver(username, driver)
    layout = stack do
      para "Name: #{driver.name}"
      para "Truck: #{driver.truck.plate_number}"
      para "Task: #{driver.task.status}"
      para "Messages: #{driver.messages_list}"
      para "Files: #{driver.files_list}"
      button 'back' do
        layout.clear {}
        login_manager(username)
      end
    end
  end

  def add_driver(username)
    layout = window do
      stack do
        para 'Driver name'
        name = edit_line
        para 'Task title'
        task_title = edit_line
        para 'Truck plate number'
        plate_number = edit_line
        button 'create' do
          layout.close
          DriversManager.new.add_driver(username, name, task_title, plate_number)
        end
      end
    end
  end
end

class DriversManager
  def drivers(username)
    driver = Driver.new
    driver.name = 'John'
    driver.task = Task.new
    driver.truck = Truck.new
    driver.add_message("dsgsfe")
    driver.add_message("sdfgreecv")
    driver.add_file("dsdfsrf.txt")
    [driver]
  end
  
  def add_driver(username, name, task_title, truck_number)
    
  end
end
