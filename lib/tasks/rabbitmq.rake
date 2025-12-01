namespace :rabbitmq do
  desc "Start the order created consumer loop"
  task consume_orders: :environment do
    OrderEvents::OrderCreatedConsumer.new.start
  end
end

