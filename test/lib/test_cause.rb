require_relative '../test_helper'

describe RallyOrgApi::Cause do
  before { @class = RallyOrgApi::Cause }
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
      [:id, :name, :cause_type, :cause_type_category,
        :image_url, :website_url, :rally_url,
        :headline, :blurb, :location, :location_zip
      ].each do |variable|
        it "for #{variable}" do
          @model.send("#{variable}=", :foo)
          @model.send(variable).must_equal :foo
        end
      end
    end

    describe "times" do
      [:created_at]
      it "for :created_at" do
        @model.send(:created_at=, "2013-08-08 14:28:26")
        @model.created_at.must_equal Time.new(*%w(2013 08 08 14 28 26))
      end
    end

    describe "numbers" do
      [:supporter_count, :total_raised, :donation_count, :current_fundraising_goal, :raised_toward_fundraising_goal
      ].each do |variable|
        it "for #{variable}, trust input JSON to be correct (accept any input)" do
          @model.send("#{variable}=", 'string').must_equal 'string'
          @model.send("#{variable}=", 5)
          @model.send(variable).must_equal 5
        end
      end
    end
  end

  describe "#to_s" do
    context "when set" do
      before { @model = @class.new(id: 1) }
      it "returns the id" do
        @model.to_s.must_equal 1
      end
    end
    context "when not set" do
      before { @model = @class.new }
      it "returns the id" do
        @model.to_s.must_equal nil
      end
    end
  end

  $request_methods.call(:top_donors, :top_donors_for_cause)
  $request_methods.call(:fundraisers, :fundraisers_for_cause)
  $request_methods.call(:donations, :donations_for_cause)
end
