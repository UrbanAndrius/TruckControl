# Controller checks input and saves new accounts
class Controller
  attr_reader :usernames, :passwords, :action
  def initialize
    @usernames = ""
    @passwords = ""
    @action = false
    @id = 856926
  end
#Check_input checks if there is already an admin with that exact name and username (Same name but not password or vice versa is accepted)
  def check_input(username, password)
      File.foreach("admin_acc.txt").with_index do |line|
        if line.include? username and line.include? password
          @usernames = username
          @passwords = password
          return true
        end
      end
      return false
  end
#Save_new_account adds new admins to the list
  def save_new_account(username, password)
      if !check_input(username, password)
        file = File.open("admin_acc.txt", "a")
        file.write(username + " " + password + "\n")
      else
        puts "username and password is already taken"
      end

      file.close
  end
#Save_new_driver adds generated id, username and surname  !!!(data stored can be changed to something else if it does not meet the need criteria given to coder)
  def save_new_driver(username, surname)
      file = File.open("drivers.txt", "a")
      new_driver_id()
      file.write(@id.to_s + " " + username + " " + surname + "\n")

      file.close
  end
#New_driver_id generates random number of 6 length and stores it in @id
  def new_driver_id()
    File.foreach("drivers.txt").with_index do |line|
      @id = 100000 + rand(900000)
      if !line.include? @id.to_s
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
end
