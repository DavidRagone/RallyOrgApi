require_relative '../test_helper'

describe RallyOrgApi do
  before { @module = RallyOrgApi }
  describe ".config" do
    it "yields to block, passing self" do
      ->{ @module.configure {|u| print u}}.must_output 'RallyOrgApi'
    end
  end

  describe ".client_key=, .client_key" do
    it "stores client_key" do
      @module.client_key = 'asdf'
      @module.client_key.must_equal 'asdf'
    end
  end

  describe ".client_secret=, .client_secret" do
    it "stores client_secret" do
      @module.client_secret = 'asdf'
      @module.client_secret.must_equal 'asdf'
    end
  end

  describe ".redirect_uri=, .redirect_uri" do
    it "stores redirect_uri" do
      @module.redirect_uri = 'http'
      @module.redirect_uri.must_equal 'http'
    end
  end

  describe ".uris" do
    it "stores uris" do
      @module.uris.keys.must_include(:oauth)
    end
  end

  describe ".authorize" do
    before do
      @module.client_key = '123'
      @module.redirect_uri = 'http'
    end

    it "visits auth url" do
      rest_client_mock = MiniTest::Mock.new
      @module.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect :get, :return_value, ['http://rally.org/oauth/au'\
          'thorize?client_id=123&response_type=code&redirect_uri=http']
        @module.authorize
        rest_client_mock.verify
      end
    end
  end

  describe ".access_token" do
    before do
      @module.client_key = 'client_key'
      @module.client_secret = 'client_secret'
      @module.redirect_uri = 'redirect_url'
    end

    it "requests access_token" do
      rest_client_mock = MiniTest::Mock.new
      @module.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect :get, "{}", ["https://rally.org/oauth/"\
          "token/?client_id=client_key&client_secret=client_secret&code=auth_code"\
          "&grant_type=authorization_code&redirect_uri=redirect_url"]
        @module.access_token('auth_code')
        rest_client_mock.verify
      end
    end

    it "returns access token" do
      @module.stub(:get, '{"token_type":"bearer","access_token":"YOUR ACCESS TOKEN"}') do
        @module.access_token('auth_code').must_equal "YOUR ACCESS TOKEN"
      end
    end
  end
end
