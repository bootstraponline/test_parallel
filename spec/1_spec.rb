require_relative 'spec_helper'

describe '1' do
  it 'a', sauce: true do
    run_test 'a'
  end

  it 'b', sauce: true do
    run_test 'b'
  end
end
