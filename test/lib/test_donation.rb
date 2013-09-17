require_relative '../test_helper'

describe RallyOrgApi::Donation do
  before { @class = RallyOrgApi::Donation }
  it { @class.must_be_kind_of Class }

  describe ".new" do
    it "sets values from input hash" do
      new_class = @class.new({id: 'bar'})
      new_class.instance_variables.must_include(:@id)
    end
  end

  describe "instance_variables, readers, writers" do
    before { @model = @class.new }

    describe "strings" do
      %i(id private first_name last_name email currency payment_type payment_method
        phone_number occupation employer gender address_country address_address1
        address_city address_state address_zip refunded custom_field_values
        fundraiser_id cover_id
      ).each do |variable|
        it "for #{variable}" do
          @model.send("#{variable}=", :foo)
          @model.send(variable).must_equal :foo
        end
      end
    end

    describe "numbers" do
      %i(amount_cents transaction_fee).each do |variable|
        it "for #{variable}, trust input JSON to be correct (accept any input)" do
          @model.send("#{variable}=", 'string').must_equal 'string'
          @model.send("#{variable}=", 5)
          @model.send(variable).must_equal 5
        end
      end
    end

    describe "time" do
      it "for created_at" do
        @model.send(:created_at=, "2013-08-08 14:28:26")
        @model.created_at.must_equal Time.new(*%w(2013 08 08 14 28 26))
      end

      it "for birthdate" do
        @model.send(:birthdate=, "1980-07-09")
        @model.birthdate.must_equal Time.new('1980', '07', '09')
      end
    end
  end

  describe "#set_cause" do
    before { @model = @class.new }
    it "is custom writer that returns the Donor, not written attr" do
      @model.set_cause('a').must_equal @model
    end
  end

  describe "#cause" do
    before { @model = @class.new }
    it "returns cause if it's a RallyOrgApi::Cause" do
      cause = RallyOrgApi::Cause.new
      @model.set_cause(cause)
      @model.cause.must_equal cause
    end

    it "makes request for cause if it is not a RallyOrgApi::Cause" do
      cause = RallyOrgApi::Cause.new
      @model.set_cause('some_id')
      @mock_requester = MiniTest::Mock.new
      @mock_requester.expect :cause, cause, ['some_id']
      @model.stub(:request, @mock_requester) do
        @model.cause
        @mock_requester.verify
        @model.cause.must_equal cause
      end
    end

    it "returns nil if cause is falsey" do
      @model.cause.must_equal nil
    end
  end
end
