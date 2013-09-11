class RallyOrgApi::Request
  include RallyOrgApi::WebRequests

  def initialize(access_token)
    @access_token = access_token
  end

  def discover
    JSON.parse(get(uris(:discover))).map do |cause_data|
      RallyOrgApi::Cause.new(cause_data)
    end
  end

  def causes
    JSON.parse(get(uris(:causes))).map do |cause_data|
      RallyOrgApi::Cause.new(cause_data)
    end      
  end

  def cause(id)
    RallyOrgApi::Cause.new(JSON.parse(get(uris(:cause, id))))
  end

  def top_donors_for_cause(id)
    get 'url'
  end

  def fundraisers_for_cause(id)
    JSON.parse(get(uris(:cause, id, '/fundraisers'))).map do |fundraiser_data|
      RallyOrgApi::Fundraiser.new(fundraiser_data['fundraiser'])
    end
  end

  def donations_for_cause(id)
    get 'url'
  end

  def fundraisers
    get 'url'
  end

  def fundraiser
    get 'url'
  end

  def top_donors_for_fundraiser(id)
    get 'url'
  end

  private
  attr_reader :access_token

  def uris(uri, id='', relation='')
    {
      discover: "https://rally.org/api/discover",
      causes: "https://rally.org/api/causes",
      cause: "https://rally.org/api/causes/",
    }[uri] + id + relation + "?access_token=#{access_token}"
  end
end