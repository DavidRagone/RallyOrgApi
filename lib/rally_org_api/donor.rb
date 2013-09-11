class RallyOrgApi::Donor
  def initialize(options = {})
    options.each_pair { |k,v| send("#{k}=", v)}
  end

  attr_reader :id, :first_name, :last_name, :amount

  private
  attr_writer :id, :first_name, :last_name, :amount
end