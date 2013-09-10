require "rally_org_api/web_requests"

module RallyOrgApi
  class << self
    include WebRequests

    attr_accessor :client_key, :client_secret, :redirect_uri
    def configure
      yield self
    end

    def uris
      {
        oauth: "http://rally.org/oauth/authorize?client_id=#{client_key}"\
          "&response_type=code&redirect_uri=#{redirect_uri}",
        access_token: ->(auth_code) { "https://rally.org/oauth/token/?"\
          "client_id=#{client_key}&client_secret=#{client_secret}&code=#{auth_code}&"\
          "grant_type=authorization_code&redirect_uri=#{redirect_uri}" }
      }
    end

    def authorize
      get(uris[:oauth])
    end

    def access_token(auth_code)
      JSON.parse(get(uris[:access_token].call(auth_code)))['access_token']
    end
  end
end

require "rally_org_api/version"
require "rally_org_api/request"
require "rally_org_api/cause"
require "rally_org_api/fundraiser"
require "rally_org_api/donor"
require "rally_org_api/donation"