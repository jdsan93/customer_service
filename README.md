# Customer Service

## Overview

`customer_service` is a Rails 7 API that owns the customer directory and order counts.
It provides:

- `GET /customers/:id` – returns the customer profile (name, address, `orders_count`).
- A RabbitMQ consumer (`bin/rails order_events:consume`) that listens for
  `order.created` events and increments the matching customer's `orders_count`.

All customer data lives in PostgreSQL and a seed file keeps a small catalog for local
testing.

## Dependencies

- Ruby 3.0.2 / Bundler 2.4.x
- PostgreSQL (same DB server used by the root project)
- RabbitMQ connection string (`RABBITMQ_URL`)

## Running locally

```bash
bundle install
bin/rails db:prepare db:seed
RABBITMQ_URL=amqp://guest:guest@localhost:5672 bin/rails s -b 0.0.0.0 -p 4000
```

To update `orders_count` automatically, start the consumer in a separate terminal:

```bash
RABBITMQ_URL=amqp://guest:guest@localhost:5672 bin/rails order_events:consume
```

When the order service publishes `order.created`, this consumer loads the customer and
increments their running order total. The API can then be queried by the order service
or any other consumer that needs customer metadata.

For end-to-end instructions coordinating both services, refer to the parent
`README.md` in the repository root.
