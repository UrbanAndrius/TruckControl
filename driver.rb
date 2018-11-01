class Driver
  attr_accessor :task, :truck, :messages, :files, :name
  def initialize
    @messages = []
    @files = []
  end

  def add_message(message)
    messages.push(message)
  end

  def add_file(file_name)
    files.push(file_name)
  end

  def info
    "Name: #{name}"
  end
end
