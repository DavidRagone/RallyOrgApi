require_relative '../test_helper'

describe RallyOrgApi::Donor do
  before { @class = RallyOrgApi::Donor }
  it { @class.must_be_kind_of Class }

  describe ".new" do
    it "sets values from input hash" do
      new_class = @class.new({id: 'bar'})
      new_class.instance_variables.must_include(:@id)
    end
  end

  describe "instance_variables, readers, writers" do
    before { @model = @class.new }
    [:id, :first_name, :last_name, :amount].each do |variable|
      it "for #{variable}" do
        @model.send("#{variable}=", :foo)
        @model.send(variable).must_equal :foo
      end
    end
  end

  describe "#set_cause" do
    before { @model = @class.new }
    it "is custom writer that returns the Donor, not written attr" do
      @model.set_cause('a').must_equal @model
    end
  end

  describe "#set_fundraiser" do
    before { @model = @class.new }
    it "is custom writer that returns the Donor, not written attr" do
      @model.set_fundraiser('a').must_equal @model
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

  describe "#fundraiser" do
    before { @model = @class.new }
    it "returns fundraiser if it's a RallyOrgApi::Fundraiser" do
      fundraiser = RallyOrgApi::Fundraiser.new
      @model.set_fundraiser(fundraiser)
      @model.fundraiser.must_equal fundraiser
    end

    it "makes request for fundraiser if it is not a RallyOrgApi::Fundraiser" do
      fundraiser = RallyOrgApi::Fundraiser.new
      @model.set_fundraiser('some_id')
      @mock_requester = MiniTest::Mock.new
      @mock_requester.expect :fundraiser, fundraiser, ['some_id']
      @model.stub(:request, @mock_requester) do
        @model.fundraiser
        @mock_requester.verify
        @model.fundraiser.must_equal fundraiser
      end
    end

    it "returns nil if fundraiser is falsey" do
      @model.fundraiser.must_equal nil
    end
  end
end
