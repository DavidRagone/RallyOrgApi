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
        @model.cause('a').created_at.must_be_instance_of Time
      end
    end
  end

  describe "#top_donors_for_cause" do
    it { @model.must_respond_to :top_donors_for_cause }
    it "makes request to cause/:id/top_donors endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '[]',
          ['https://rally.org/api/causes/POLIKUJJ/top_donors?access_token=token'])
        @model.top_donors_for_cause('POLIKUJJ')
        rest_client_mock.verify
      end
    end

    it 'returns an Array of donor objects' do
      response = '[
          {
            "first_name": "Billy",
            "last_name": "Mays",
            "id": "nsbhdyfs",
            "amount": 900
          },
          {
            "first_name": "Sally",
            "last_name": "Heaps",
            "id": "nsbhdyfs",
            "amount": 800
          },
          {
            "first_name": "Jeffery",
            "last_name": "Giant",
            "id": "nsbhdyfs",
            "amount": 700
          }
        ]'
      @model.stub(:get, response) do
        @model.top_donors_for_cause('a').must_be_instance_of Array
        @model.top_donors_for_cause('a').each do |response|
          response.must_be_instance_of RallyOrgApi::Donor
        end
      end
    end
  end

  describe "#fundraisers_for_cause" do
    it { @model.must_respond_to :fundraisers_for_cause }

    it "makes request to cause/:id/fundraisers endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{}',
          ['https://rally.org/api/causes/ABCDEFGH/fundraisers?access_token=token'])
        @model.fundraisers_for_cause('ABCDEFGH')
        rest_client_mock.verify
      end
    end

    it "returns an Array of fundraiser objects" do
      response = '[
  {
    "fundraiser": {
      "current_fundraising_goal": null,
      "donation_count": 13,
      "created_at": "2012-07-12T11:50:56-07:00",
      "total_raised": 4500,
      "supporter_count": 7,
      "rally_url": "https://rally.org/cuteanimalpictures/POLIKUJJ/billymays",
      "id": "POLIKUJJ",
      "raised_toward_fundraising_goal": null,
      "cause_id": "ABCDEFGH",
      "user": {
        "name": "Billy Mays",
        "icon_url": "https://some.url/here/pops.jpg",
        "id": "nsbhdyfs"
      }
    }
  },
  {
    "fundraiser": {
      "current_fundraising_goal": null,
      "donation_count": 0,
      "created_at": "2012-08-23T16:52:26-07:00",
      "total_raised": 0,
      "supporter_count": 0,
      "rally_url": "https://rally.org/cuteanimalpictures/YUKYUKYUK/sally",
      "id": "YUKYUKYUK",
      "raised_toward_fundraising_goal": null,
      "cause_id": "ABCDEFGH",
      "user": {
        "name": "Sally Heaps",
        "icon_url": "https://some.url/here/pops.jpg",
        "id": "baMBaMbAm"
      }
    }
  }
]'
      @model.stub(:get, response) do
        @model.fundraisers_for_cause('a').must_be_instance_of Array
        @model.fundraisers_for_cause('a').each do |response|
          response.must_be_instance_of RallyOrgApi::Fundraiser
        end
      end
    end
  end

  describe "#donations_for_cause" do
    #This returns a list, which can be empty, of all the donations for a cause 
    #  (specified by ID).
    #Since lists of donations can be very long, the donations endpoint is paginated. 
    #  The default result set will be 25 donations and additional donations can be 
    #  retrieved using the page parameter. Each page will return a set of 25 donations, 
    #  ordered by created_at date.
    #Optional parameters start_date and end_date may also be used. The result will 
    #  include donations with created_at date between start_date and end_date Date 
    #  should be in the format of "YYYY-MM-DD"

    it { @model.must_respond_to :donations_for_cause }
    it "makes request to cause/:id/fundraisers endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{}',
          ['https://rally.org/api/causes/SSOTORP/donations?access_token='\
            'token&page=7&start_date=2013-01-01&end_date=2013-02-01'])
        @model.donations_for_cause(
          'SSOTORP',
          page: 7,
          start_date: '2013-01-01',
          'end_date' => '2013-02-01'
        )
        rest_client_mock.verify
      end
    end

    it "returns an Array of donation objects" do
      response = '[
        {
          "id":"8GU4ICC33TL",
          "private":false,
          "first_name":"Sarah",
          "last_name":"Kerrigan",
          "email":"somebody-2@example.com",
          "amount_cents":1000,
          "currency":"usd",
          "transaction_fee":57,
          "payment_type":"cc",
          "payment_method":"visa",
          "phone_number":"5551234567",
          "occupation":"Nurse",
          "employer":"Acme Widgets",
          "gender":"F",
          "address_country":"US",
          "address_address1":"123 Mar Sara street",
          "address_city":"San Francisco",
          "address_state":"CA",
          "address_zip":"94110",
          "refunded":false,
          "created_at":"2013-03-14 11:28:33",
          "birthdate":"1980-07-09",
          "custom_field_values":[{"A Name":"whatever"}],
          "fundraiser_id":"3MGmTYb9KQF"
          },

         {
          "id":"kauwjI02gFX",
          "private":false,
          "first_name":"James",
          "last_name":"Raynor",
          "email":"somebody-3@example.com",
          "amount_cents":1000,
          "currency":"usd",
          "transaction_fee":57,
          "payment_type":"cc",
          "payment_method":"visa",
          "phone_number":"5928372222",
          "occupation":"Professional gamer",
          "employer":"Acme Widgets",
          "gender":"M",
          "address_country":"US",
          "address_address1":"999 Aiur road",
          "address_city":"San Francisco",
          "address_state":"CA",
          "address_zip":"94110",
          "refunded":false,
          "created_at":"2013-03-14 11:28:33",
          "birthdate":"1980-07-09",
          "custom_field_values":[],
          "fundraiser_id":"3MGmTYb9KQF",
          "cover_id":"aY3IEHPU1iY"
          }
        ]'
      @model.stub(:get, response) do
        @model.donations_for_cause('a').must_be_instance_of Array
        @model.donations_for_cause('a').each do |response|
          response.must_be_instance_of RallyOrgApi::Donation
        end
      end
    end
  end

  describe "#fundraisers" do
    it { @model.must_respond_to :fundraisers }
  end

  describe "#fundraiser" do
    it { @model.must_respond_to :fundraiser }

    it "makes request to fundraisers/:id endpoint" do
      rest_client_mock = MiniTest::Mock.new
      @model.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect(:get, '{"fundraiser": {}}',
          ['https://rally.org/api/fundraisers/POLIKUJJ?access_token=token'])
        @model.fundraiser('POLIKUJJ')
        rest_client_mock.verify
      end
    end

    it "returns a fundraiser object" do
      response = '{
            "fundraiser": {
              "current_fundraising_goal": null,
              "donation_count": 13,
              "created_at": "2012-07-12T11:50:56-07:00",
              "total_raised": 4500,
              "supporter_count": 7,
              "rally_url": "https://rally.org/cuteanimalpictures/POLIKUJJ/billymays",
              "id": "POLIKUJJ",
              "raised_toward_fundraising_goal": null,
              "cause_id": "ABCDEFGH",
              "user": {
                "name": "Billy Mays",
                "icon_url": "https://some.url/here/pops.jpg",
                "id": "nsbhdyfs"
              }
            }
        }'
      @model.stub(:get, response) do
        @model.fundraiser('a').must_be_instance_of RallyOrgApi::Fundraiser
      end
    end
  end

  describe "#top_donors_for_fundraiser" do
    it { @model.must_respond_to :top_donors_for_fundraiser }
  end
end