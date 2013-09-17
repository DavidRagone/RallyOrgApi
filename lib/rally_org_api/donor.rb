class RallyOrgApi::Donor
  def initialize(options = {})
    options.each_pair { |k,v| send("#{k}=", v)}
  end

  attr_reader :id, :first_name, :last_name, :amount, :cause

  def set_cause(cause)
    @cause = cause
    self
  end

  def set_fundraiser(fundraiser)
    @fundraiser = fundraiser
    self
  end

  def cause
    if @cause.is_a? RallyOrgApi::Cause
      @cause
    elsif !!@cause
      @cause = request.cause(@cause)
    end
  end

  def fundraiser
    if @fundraiser.is_a? RallyOrgApi::Fundraiser
      @fundraiser
    elsif !!@fundraiser
      @fundraiser = request.fundraiser(@fundraiser)
    end
  end

  private

  attr_writer :id, :first_name, :last_name, :amount, :request
  attr_reader :request
end
