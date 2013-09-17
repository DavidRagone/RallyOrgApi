class RallyOrgApi::Donation
  # id : The unique id for the donation.
  # custom_field values : A list of custom fields and values
  # cover_id : The cover which the donation is donated from
  # refunded : Indicates if donation has been refunded

  def initialize(options={})
    options.each_pair { |k,v| send("#{k}=", v) }
  end

  attr_reader :id, :private, :first_name, :last_name, :email, :amount_cents,
    :currency, :transaction_fee, :payment_type, :payment_method, :phone_number,
    :occupation, :employer, :gender, :address_country, :address_address1,
    :address_city, :address_state, :address_zip, :refunded, :birthdate,
    :custom_field_values, :fundraiser_id, :cover_id, :created_at, :cause

  def set_cause(cause)
    @cause = cause
    self
  end

  private

  attr_writer :id, :private, :first_name, :last_name, :email, :currency,
    :payment_type, :payment_method, :phone_number, :occupation, :employer,
    :gender, :address_country, :address_address1, :address_city, :address_state,
    :address_zip, :refunded, :custom_field_values, :fundraiser_id,
    :cover_id, :amount_cents, :transaction_fee

  def birthdate=(birthdate)
    @birthdate = Time.new(*birthdate.split(/\W+/))
  end

  def created_at=(created_at)
    @created_at = Time.new(*created_at.split(/\W+/))
  end
end
