require 'rspec'

require_relative 'driver'
require_relative 'truck'
require_relative 'task'

describe('Driver') do
  it 'should return string of messages' do
    driver = Driver.new
    driver.add_message('123')
    driver.add_message('abc')
    messages = driver.messages_list
    expect(messages).to include('123', 'abc', "\n")
  end

  it 'should return string of file names' do
    driver = Driver.new
    driver.add_file('test.txt')
    driver.add_file('abc.json')
    messages = driver.files_list
    expect(messages).to include('test.txt', 'abc.json', "\n")
  end

  it 'should accept only Truck objects' do
    driver = Driver.new
    driver.truck = 'abc'
    expect(driver.truck).to eql(nil)
  end
end

describe('Driver') do
  it 'should accept only Task objects' do
    driver = Driver.new
    driver.task = 5
    expect(driver.task).to eql(nil)
  end

  it 'should accept only not empty strings' do
    driver = Driver.new
    driver.name = 'abc'
    driver.name = ''
    expect(driver.name).to eql('abc')
  end
end
