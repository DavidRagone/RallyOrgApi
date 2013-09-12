require 'minitest/pride'
require 'minitest/autorun'
require 'rally_org_api'
require 'rest-client'
require 'json'

alias :context :describe

$request_methods = ->(method, request_method) do
  describe "##{method}" do
    before { @model = @class.new }

    it "requests #{method.to_s.gsub('_', ' ')}" do
      @mock_requester = MiniTest::Mock.new
      @mock_requester.expect request_method, :return_value, [@model.id]
      @model.stub(:request, @mock_requester) do
        @model.send(method)
        @mock_requester.verify
      end
    end

    it "memoizes" do
      @mock_requester = MiniTest::Mock.new
      @mock_requester.expect request_method, :return_value, [@model.id]
      @model.stub(:request, @mock_requester) do
        @model.send(method)
        @mock_requester.verify
        @model.instance_variables.must_include "@#{method}".to_sym
        @mock_requester.expect request_method, true
        @model.send(method)
        assert_raises(MockExpectationError, "#{request_method} should not be called (memoized)") do
          @mock_requester.verify
        end
      end
    end
  end
end
