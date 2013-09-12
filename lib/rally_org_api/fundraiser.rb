class RallyOrgApi::Fundraiser
  #The fundraiser objects uses many of the same fields as cause objects do, the additions are
  #  cause_id : The unique id for the cause.
  #  user : The user object who started that fan-fundraiser.
  #  name : A string of the name of the user
  #  icon_url : A string of the url for that user's icon
  #  id : A unique id for that user.

  def initialize(options = {})
    options.each_pair { |k,v| send("#{k}=", v)}
  end

  attr_reader :id, :name, :created_at, :total_raised, :donation_count,
    :current_fundraising_goal, :raised_toward_fundraising_goal, 
    :supporter_count, :rally_url, :cause_id, :user

  def top_donors
    @top_donors ||= request.top_donors_for_fundraiser(id)
  end

  private
  attr_writer :id, :name, :created_at, :total_raised, :donation_count,
    :current_fundraising_goal, :raised_toward_fundraising_goal, 
    :supporter_count, :rally_url, :cause_id, :user

  def request
    RallyOrgApi::Request
  end
end
