module OrderEvents
  class OrderCreatedConsumer
    def initialize(connection: Rabbitmq::Connection.build, logger: Rails.logger)
      @connection = connection
      @logger = logger
      @queue_name = Rails.configuration.x.order_events.queue
      @exchange_name = Rails.configuration.x.order_events.exchange
      @routing_key = Rails.configuration.x.order_events.routing_key
    end

    def start
      connection.start
      channel = connection.create_channel
      queue = channel.queue(queue_name, durable: true)
      exchange = channel.direct(exchange_name, durable: true)
      queue.bind(exchange, routing_key: routing_key)

      logger.info("Listening for order.created events on #{queue_name}")

      queue.subscribe(manual_ack: true, block: true) do |delivery_info, _properties, payload|
        process_payload(payload)
        channel.ack(delivery_info.delivery_tag)
      rescue StandardError => e
        logger.error("Failed processing order event: #{e.message}")
        channel.nack(delivery_info.delivery_tag, false, true)
      end
    ensure
      channel&.close
      connection.close if connection.open?
    end

    private

    attr_reader :connection, :logger, :queue_name, :exchange_name, :routing_key

    def process_payload(payload)
      data = JSON.parse(payload)
      OrderEvents::OrderCreatedProcessor.new(data).call
    end
  end
end

