# driver completes tasks given by manager
class Driver
  attr_reader :files, :messages, :task, :truck, :name

  def initialize
    @messages = []
    @files = []
    @name = 'undefined'
  end

  def add_message(message)
    @messages.push(message)
  end

  def add_file(file_name)
    @files.push(file_name)
  end

  def name=(name)
    @name = name unless name.to_s.empty?
  end

  def truck=(truck)
    @truck = truck if truck.is_a?(Truck)
  end

  def task=(task)
    @task = task if task.is_a?(Task)
  end

  def messages_list
    result = ''
    messages.each { |message| result += "\n" + message  }
    result
  end

  def files_list
    result = ''
    files.each { |file| result += "\n" + file }
    result
  end
end
