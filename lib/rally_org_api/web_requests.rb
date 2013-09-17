module RallyOrgApi
  module WebRequests
    def get(url)
      web_request.get url
    end

    private

    def web_request
      RestClient
    end
  end
end
