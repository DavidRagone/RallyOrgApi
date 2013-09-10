require_relative '../test_helper'
require 'rest-client'

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

  describe "URI" do
    it "stores uris" do
      @module.uris.keys.must_include(:oauth)
    end
  end

  describe "authorize" do
    it "visits auth url" do
      @module.client_key = '123'
      @module.redirect_uri = 'http'
      rest_client_mock = MiniTest::Mock.new
      @module.stub(:web_request, rest_client_mock) do
        rest_client_mock.expect :get, :return_value, ['http://rally.org/oauth/authorize?client_id=123&response_type=code&redirect_uri=http']
        @module.authorize
        rest_client_mock.verify
      end
    end
  end
end
