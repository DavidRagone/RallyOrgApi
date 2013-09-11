require_relative '../test_helper'

describe RallyOrgApi::Fundraiser do
  before { @class = RallyOrgApi::Fundraiser }
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
    :current_fundraising_goal, :raised_toward_fundraising_goal, 
    :supporter_count, :rally_url, :cause_id, :user
    ].each do |variable|
      it "for #{variable}" do
        @model.send("#{variable}=", :foo)
        @model.send(variable).must_equal :foo
      end
    end
  end
end