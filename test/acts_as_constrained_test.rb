require 'test_helper'

class ActsAsConstrainedTest < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, ActsAsConstrained
  end
end
