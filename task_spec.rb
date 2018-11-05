require 'rspec'

require_relative 'task'
require_relative 'route'

describe 'Task' do
  it 'should accept Route objects' do
    task = Task.new
    task.route = 'a'
    expect(task.route).to eql(nil)
  end

  it 'should not accept empty string for title' do
    task = Task.new
    task.title = 'abc'
    task.title = ''
    expect(task.title).to eql('abc')
  end

  it 'should not accept empty string for status' do
    task = Task.new
    task.status = 'abc'
    task.status = ''
    expect(task.status).to eql('abc')
  end
end
