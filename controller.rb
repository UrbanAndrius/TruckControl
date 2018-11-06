# Controller checks input and saves new accounts
class Controller
  attr_reader :usernames, :passwords, :action
  def initialize
    @usernames = "sdfsdf"
    @passwords = "sdfsdf"
    @action = false
    @id = 856926
    @text_file = []
    @driver_file = []
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
      file.write(@id.to_s + " " + username + " " + password + "\n")

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

    @text_file = []
    @driver_file = []
    File.foreach("drivers.txt").with_index do |line|
      arr = line.split(' ')
      arr.each do |word|
        @text_file += word.split
      end
      #puts @text_file
      #puts @id
      if @text_file.include? @id
        @driver_file += @text_file
      end
      @text_file = []
    end
    @driver_file
  end
end
