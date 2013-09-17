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

  def top_donors_for_cause(cause)
    JSON.parse(get(uris(:cause, cause, '/top_donors'))).map do |donor_data|
      RallyOrgApi::Donor.new(donor_data)
    end
  end

  def fundraisers_for_cause(cause)
    JSON.parse(get(uris(:cause, cause, '/fundraisers'))).map do |fundraiser_data|
      RallyOrgApi::Fundraiser.new(fundraiser_data['fundraiser'])
    end
  end

  def donations_for_cause(cause, options={})
    # options[:start_date] YYYY-MM-DD
    # options[:end_date]
    # options[:page]
    JSON.parse(get(uris(:cause, cause, '/donations', options))).map do |donation_data|
      RallyOrgApi::Donation.new(donation_data)
    end
  end

  def fundraisers
    JSON.parse(get(uris(:fundraiser))).map do |fundraiser_data|
      RallyOrgApi::Fundraiser.new(fundraiser_data['fundraiser'])
    end
  end

  def fundraiser(id)
    RallyOrgApi::Fundraiser.new(JSON.parse(get(uris(:fundraiser, id)))['fundraiser'])
  end

  def top_donors_for_fundraiser(fundraiser)
    JSON.parse(get(uris(:fundraiser, fundraiser, '/top_donors'))).map do |donor_data|
      RallyOrgApi::Donor.new(donor_data)
    end
  end

  private
  attr_reader :access_token

  def uris(uri, id='', relation='', params={})
    additional_params = params.any? ? params.map { |k,v| "&#{k}=#{v}" }.join : ''
    root = {
      discover: "https://rally.org/api/discover",
      causes: "https://rally.org/api/causes",
      cause: "https://rally.org/api/causes/",
      fundraiser: "https://rally.org/api/fundraisers/"
    }[uri]
   "#{root}#{id}#{relation}?access_token=#{access_token}#{additional_params}"
  end
end
