# Controller checks input and saves new accounts
class Controller
  attr_reader :usernames, :passwords, :action
  def initialize
    @usernames = ""
    @passwords = ""
    @action = false
  end

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

  def save_new_account(username, password)
      if !check_input(username, password)
        file = File.open("admin_acc.txt", "a")
        file.write(username + " " + password + "\n")
      else
        puts "username and password is already taken"
      end

      file.close unless file.nil?
  end


end
