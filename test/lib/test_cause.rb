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
    [:id, :name, :created_at, :total_raised, :donation_count,
    :current_fundraising_goal, :raised_toward_fundraising_goal, :cause_type,
    :cause_type_category, :image_url, :supporter_count, :website_url, :rally_url,
    :headline, :blurb, :location, :location_zip].each do |variable|
      it "for #{variable}" do
        @model.send("#{variable}=", :foo)
        @model.send(variable).must_equal :foo
      end
    end
  end
end