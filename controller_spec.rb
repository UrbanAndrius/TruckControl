require 'rspec'

require_relative 'controller'

describe 'Controller' do
  it 'should generate 6 digit random id' do
    controller = Controller.new
    id = controller.new_driver_id
    expect(id).to be_between(99_999, 1_000_000).inclusive
  end
end
