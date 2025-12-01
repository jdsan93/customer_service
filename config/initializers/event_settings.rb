Rails.application.configure do
  config.x.order_events.exchange = ENV.fetch("ORDER_EVENTS_EXCHANGE", "orders")
  config.x.order_events.queue = ENV.fetch("ORDER_EVENTS_QUEUE", "customer_service.orders")
  config.x.order_events.routing_key = ENV.fetch("ORDER_EVENTS_ROUTING_KEY", "order.created")
end

