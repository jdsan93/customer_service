module OrderEvents
  class OrderCreatedProcessor
    def initialize(payload, logger: Rails.logger)
      @payload = payload
      @logger = logger
    end

    def call
      customer = Customer.find(payload.fetch("customer_id"))
      customer.increment!(:orders_count)
      logger.info("Incremented orders_count for customer ##{customer.id}")
    rescue ActiveRecord::RecordNotFound
      logger.warn("Customer #{payload['customer_id']} not found for order event #{payload['order_id']}")
    end

    private

    attr_reader :payload, :logger
  end
end

