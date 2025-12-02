module OrderEvents
  class OrderCreatedProcessor
    def initialize(payload, logger: Rails.logger)
      @payload = payload
      @logger = logger
    end

    def call
      customer_id = extract_customer_id
      raise KeyError, "customer_id missing in payload" unless customer_id

      customer = Customer.find(customer_id)
      customer.increment!(:orders_count)
      logger.info("Incremented orders_count for customer ##{customer.id}")
    rescue ActiveRecord::RecordNotFound
      logger.warn("Customer #{customer_id} not found for order event #{extract_order_id}")
    end

    private

    attr_reader :payload, :logger

    def extract_customer_id
      payload["customer_id"] || payload.dig("order", "customer_id")
    end

    def extract_order_id
      payload["order_id"] || payload.dig("order", "id")
    end
  end
end

