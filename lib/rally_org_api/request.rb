class RallyOrgApi::Request
  include RallyOrgApi::WebRequests

  def initialize(access_token)
    @access_token = access_token
  end

  def discover
    JSON.parse(get(uris[:discover] + access_token)).map do |cause_data|
      RallyOrgApi::Cause.new(cause_data)
    end
  end

  def causes
    get 'url'
  end

  def cause(id)
    get 'url'
  end

  def top_donors_for_cause(id)
    get 'url'
  end

  def fundraisers_for_cause(id)
    get 'url'
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

  def uris
    {
      discover: "https://rally.org/api/discover?access_token="
    }
  end
end