class RallyOrgApi::Cause
  def initialize(options = {})
    options.each_pair { |k,v| send("#{k}=", v)}
  end

  attr_reader :id, :name, :created_at, :total_raised, :donation_count,
    :current_fundraising_goal, :raised_toward_fundraising_goal, :cause_type,
    :cause_type_category, :image_url, :supporter_count, :website_url, :rally_url,
    :headline, :blurb, :location, :location_zip

  def to_s
    id
  end

  def top_donors
    @top_donors ||= request.top_donors_for_cause(self)
  end

  def fundraisers
    @fundraisers ||= request.fundraisers_for_cause(self)
  end

  def donations
    @donations ||= request.donations_for_cause(self)
  end

  private

  attr_writer :id, :name, :cause_type, :cause_type_category,
    :image_url, :website_url, :rally_url, :headline, :blurb, :location,
    :location_zip, :total_raised, :donation_count, :current_fundraising_goal,
    :raised_toward_fundraising_goal, :supporter_count, :request
  attr_reader :request

  def created_at=(created_at)
    @created_at = Time.new(*created_at.split(/\W+/))
  end

  # id : The unique identifier that references the cause
  # name : The cause name as a string
  # created_at : The timestamp when the cause was created (result will be sorted descending on this value).
  # total_raised : The number of the total unrefunded amount raised in cents.
  # donation_count : The number of unrefunded donations made to the cause.
  # current_fundraising_goal : The number, in cents, of the current fundraising goal or null.
  # raised_toward_fundraising_goal : The number, in cents, of the unrefunded amount raised for the current fundraising goal or null.
  # cause_type : The self selected type, eg. "Education"
  # cause_type_category : The self selected category, pretty sure this is always "Other"
  # image_url : The url of their uploaded cover image or youtube thumbnail image from the video.
  # supporter_count : The number of supporters for a cause
  # website_url : A string of the cause's personal URL or an empty string, ""
  # rally_url : A string of the cause's rally page
  # headline : A string of the cause's headline or an empty string, ""
  # blurb : A string of the cause's blurb or null
  # location : The city/state (for US rallys) or city/country (for international rallies)
  # location_zip : The zip code where the rally is registered
end
