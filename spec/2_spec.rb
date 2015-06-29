require_relative 'spec_helper'

describe '1' do
  it 'c', sauce: true do
    run_test 'c'
  end

  it 'd', sauce: true do
    run_test 'd'
  end
end
