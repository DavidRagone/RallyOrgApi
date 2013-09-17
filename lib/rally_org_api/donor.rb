class RallyOrgApi::Donor
  def initialize(options = {})
    options.each_pair { |k,v| send("#{k}=", v)}
  end

  attr_reader :id, :first_name, :last_name, :amount, :cause, :fundraiser

  def set_cause(cause)
    @cause = cause
    self
  end

  def set_fundraiser(fundraiser)
    @fundraiser = fundraiser
    self
  end

  private
  attr_writer :id, :first_name, :last_name, :amount
end
