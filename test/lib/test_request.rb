require_relative '../test_helper'

describe RallyOrgApi::Request do
  before { @model = RallyOrgApi::Request.new('token') }
  it { RallyOrgApi::Request.must_be_kind_of Class }

  describe ".new" do
    it "assigns the access token" do
      @model.instance_variable_get(:@access_token).must_equal 'token'
    end
  end

  describe "#discover" do
    it { @model.must_respond_to :discover }
    it "makes request to discover endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{}',
          ['https://rally.org/api/discover?access_token=token'])
        @model.discover
        rest_client_mock.verify
      end
    end

    it "returns an array of Cause objects" do
      response = '[
  {
    "blurb": null,
    "cause_type": "Arts, Culture, Humanities",
    "cause_type_category": "Other",
    "created_at": "2013-08-08 14:30:26",
    "current_fundraising_goal": null,
    "headline": null,
    "id": "7jl7Xu5aGRI",
    "image_url": "https://s3.aws.amazon.com/rallycall/covers/12/images/original/bg.jpg?1375997306",
    "name": "Banksy4Life",
    "raised_toward_fundraising_goal": null,
    "rally_url": "https://rally.org/banksy",
    "supporter_count": 1,
    "website_url": null,
    "location": "Berlin, Germany",
    "location_zip": "12345"
  },
  {
    "blurb": null,
    "cause_type": "Animal, Wildlife, Environment",
    "cause_type_category": "Other",
    "created_at": "2013-08-08 14:28:26",
    "current_fundraising_goal": null,
    "headline": null,
    "id": "7jl7Xu5aGRI",
    "image_url": "https://s3.aws.amazon.com/rallycall/covers/11/images/original/bg.jpg?1375997306",
    "name": "Fennec Fox Breeding",
    "raised_toward_fundraising_goal": null,
    "rally_url": "https://rally.org/foxes",
    "supporter_count": 1,
    "website_url": null,
    "location": "San Francisco, CA",
    "location_zip": "94105"
  }
]'
      @model.stub(:get, response) do
        @model.discover.must_be_instance_of Array
        @model.discover.each do |response|
          response.must_be_instance_of RallyOrgApi::Cause
        end
      end
    end
  end

  describe "#causes" do
    it { @model.must_respond_to :causes }
    it "makes request to causes endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{}',
          ['https://rally.org/api/causes?access_token=token'])
        @model.causes
        rest_client_mock.verify
      end
    end

    it "returns an array of Cause objects" do
      response = '[
  {
    "blurb": null,
    "cause_type": "Arts, Culture, Humanities",
    "cause_type_category": "Other",
    "created_at": "2013-08-08 14:30:26",
    "current_fundraising_goal": null,
    "donation_count": 5,
    "headline": null,
    "id": "7jl7Xu5aGRI",
    "image_url": "https://s3.aws.amazon.com/rallycall/covers/12/images/original/bg.jpg?1375997306",
    "name": "Banksy4Life",
    "raised_toward_fundraising_goal": null,
    "rally_url": "https://rally.org/banksy",
    "supporter_count": 1,
    "total_raised": 25000,
    "website_url": null,
    "location": "Berlin, Germany",
    "location_zip": "12345"
  },
  {
    "blurb": null,
    "cause_type": "Animal, Wildlife, Environment",
    "cause_type_category": "Other",
    "created_at": "2013-08-08 14:28:26",
    "current_fundraising_goal": null,
    "donation_count": 1,
    "headline": null,
    "id": "7jl7Xu5aGRI",
    "image_url": "https://s3.aws.amazon.com/rallycall/covers/11/images/original/bg.jpg?1375997306",
    "name": "Fennec Fox Breeding",
    "raised_toward_fundraising_goal": null,
    "rally_url": "https://rally.org/foxes",
    "supporter_count": 1,
    "total_raised": 1000,
    "website_url": null,
    "location": "San Francisco, CA",
    "location_zip": "94105"
  }
]'
      @model.stub(:get, response) do
        @model.causes.must_be_instance_of Array
        @model.causes.each do |response|
          response.must_be_instance_of RallyOrgApi::Cause
        end
      end
    end
  end

  describe "#cause" do
    it { @model.must_respond_to :cause }
    it "makes request to cause(:id) endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{}',
          ['https://rally.org/api/causes/ABCDEFGH?access_token=token'])
        @model.cause('ABCDEFGH')
        rest_client_mock.verify
      end
    end

    it "returns a Cause object" do
      response = '{
  "blurb": null,
  "cause_type": "Animal, Wildlife, Environment",
  "cause_type_category": "Other",
  "created_at": "2013-08-08 14:28:26",
  "current_fundraising_goal": null,
  "donation_count": 1,
  "headline": null,
  "id": "7jl7Xu5aGRI",
  "image_url": "https://s3.aws.amazon.com/rallycall/covers/11/images/original/bg.jpg?1375997306",
  "name": "Fennec Fox Breeding",
  "raised_toward_fundraising_goal": null,
  "rally_url": "https://rally.org/foxes",
  "supporter_count": 1,
  "total_raised": 1000,
  "website_url": null
}'
      @model.stub(:get, response) do
        @model.cause('a').must_be_instance_of RallyOrgApi::Cause
      end
    end
  end

  describe "#top_donors_for_cause" do
    it { @model.must_respond_to :top_donors_for_cause }
  end

  describe "#fundraisers_for_cause" do
    it { @model.must_respond_to :fundraisers_for_cause }
  end

  describe "#donations_for_cause" do
    it { @model.must_respond_to :donations_for_cause }
  end

  describe "#fundraisers" do
    it { @model.must_respond_to :fundraisers }
  end

  describe "#fundraiser" do
    it { @model.must_respond_to :fundraiser }
  end

  describe "#top_donors_for_fundraiser" do
    it { @model.must_respond_to :top_donors_for_fundraiser }
  end
end