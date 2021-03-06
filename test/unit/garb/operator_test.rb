require File.join(File.dirname(__FILE__), '..', '..', '/test_helper')

module Garb
  class OperatorTest < MiniTest::Unit::TestCase
    context "An instance of an Operator" do
      should "lower camelize the target" do
        assert_equal "ga:uniqueVisits=", Operator.new(:unique_visits, "=").to_google_analytics
      end

      should "return target and operator together" do
        assert_equal "ga:metric=", Operator.new(:metric, "=").to_google_analytics
      end

      should "prefix the operator to the target" do
        assert_equal "-ga:metric", Operator.new(:metric, "-", true).to_google_analytics
      end

      should "know if it is equal to another operator" do
        op1 = Operator.new(:hello, "==")
        op2 = Operator.new(:hello, "==")
        assert_equal op1, op2
      end

      should "not be equal to another operator if target, operator, or prefix is different" do
        op1 = Operator.new(:hello, "==")
        op2 = Operator.new(:hello, "==", true)
        refute_equal op1, op2
      
        op1 = Operator.new(:hello1, "==")
        op2 = Operator.new(:hello2, "==")
        refute_equal op1, op2
      
        op1 = Operator.new(:hello, "!=")
        op2 = Operator.new(:hello, "==")
        refute_equal op1, op2
      end
    end
  end
end
