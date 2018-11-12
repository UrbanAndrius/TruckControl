# Controller checks input and saves new accounts
require_relative 'driver'
require_relative 'task'
require_relative 'truck'

class Controller
  attr_reader :usernames, :passwords, :action, :driver, :truck, :task
  def initialize
    @usernames = "sdfsdf"
    @passwords = "sdfsdf"
    @action = false
    @id = 856926
    @text_file = []
    @driver_file = []
    @truck_plate = "abc852"
  end
#Check_input checks if there is already an admin with that exact name and username
  def check_input(username, password)
      File.foreach("admin_acc.txt").with_index do |line|
        arr = line.split(' ')
        arr.each do |word|
          @text_file += word.split
        end
        if @text_file.include? username and @text_file.include? password
          @usernames = username
          @passwords = password
          return true
        end
        @text_file = []
      end
      return false
  end

  def check_exists(username)
    File.foreach("admin_acc.txt").with_index do |line|
      arr = line.split(' ')
      arr.each do |word|
        @text_file += word.split
      end
      if @text_file.include? username
        @usernames = username
        return true
      end
      @text_file = []
    end
    return false
  end


#Save_new_account adds new admins to the list
  def save_new_account(username, password)
      if !check_exists(username)
        file = File.open("admin_acc.txt", "a")
        new_driver_id
        file.write(@id.to_s + " " + username + " " + password + "\n")
      else
        puts "username and password is already taken"
      end

      file.close
  end
#Load_account finds manager id by searching for username and password
  def load_account(username)
    @text_file = []
    File.foreach("admin_acc.txt").with_index do |line|
      arr = line.split(' ')
      arr.each do |word|
        @text_file += word.split
      end
      if @text_file.include? username
        @id = @text_file[0]
        puts @id.to_s + ' This is my id'
      end
      @text_file = []
    end
  end

#Save_new_driver adds manager id, username and surname
#!!!IMPORTANT use it with functions load_account and check_input, as alone it wont work how it should, as it will use default data.
#If used properly in current UI sequence, UI should cast load_account and check_input, before calling save_new_driver
  def save_new_driver(username, password)
      file = File.open("drivers.txt", "a")
      load_account(@usernames)
      @truck_plate = new_truck_number.to_s
      file.write(@id.to_s + " " + username + " " + password + " " + @truck_plate.to_s + "\n")

      file.close
  end
#New_driver_id generates random number of 6 length and stores it in @id
  def new_driver_id()
    File.foreach("admin_acc.txt").with_index do |line|
      @id = 100000 + rand(900000)
      unless line.include? @id.to_s
        return @id
      end
    end
  end
#Generates truck number
  def new_truck_number(length=3)
      source1=("A".."Z").to_a
      source2 = (0..9).to_a
      key=""
      length.times{ key += source1[rand(source1.size)].to_s }
      length.times{ key += source2[rand(source2.size)].to_s }
      return key
    end

#Give_task adds tasks to drivers at the end of the line
  def give_task(ids, task)
    file = File.open("temp.txt", "w")
    File.foreach("drivers.txt").with_index do |line|
      if line.include? ids
        file.write(line.chomp + " " + task + "\n")
      else
        file.write(line)
      end
    end
    file.close

    File.delete("drivers.txt")
    File.rename("temp.txt", "drivers.txt")
  end

  def load_driver_list(username)
    load_account(username)
    i = 0
    puts @id.to_s + ' This is my id'
    @text_file = []
    @driver_file = []
    File.foreach("drivers.txt").with_index do |line|
      arr = line.split(' ')
      arr.each do |word|
        @text_file += word.split
      end
      if @text_file.include? @id
        @driver_file[i] = @text_file
        i += 1
      end
      @text_file = []
    end
    @driver_file

  end
end

#control = Controller.new
#driv = Driver.new
#drivers = control.load_driver_list("pc")
#i = 0
#drivers.each do |driver|
#  puts "#{drivers[i][1]}"
#  i += 1
#end
