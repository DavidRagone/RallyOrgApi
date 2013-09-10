require "rally_org_api/version"

module RallyOrgApi
  class << self
    attr_accessor :client_key, :client_secret, :redirect_uri
    def configure
      yield self
    end

    def uris
      {
        oauth: "http://rally.org/oauth/authorize?client_id=#{client_key}"\
                 "&response_type=code&redirect_uri=#{redirect_uri}"
      }
    end

    def get(url)
      web_request.get url
    end

    def authorize
      get(uris[:oauth])
    end

    private
    def web_request
      RestClient
    end
  end
end
