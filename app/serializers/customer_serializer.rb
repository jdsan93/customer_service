class CustomerSerializer
  def initialize(customer)
    @customer = customer
  end

  def as_json(*)
    {
      id: @customer.id,
      customer_name: @customer.customer_name,
      address: @customer.address,
      orders_count: @customer.orders_count
    }
  end
end

