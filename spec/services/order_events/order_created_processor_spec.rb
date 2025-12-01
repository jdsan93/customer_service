require 'rails_helper'

RSpec.describe OrderEvents::OrderCreatedProcessor do
  describe "#call" do
    let(:payload) { { "order_id" => "abc", "customer_id" => customer.id } }
    let(:logger) { instance_double(Logger, info: nil, warn: nil) }

    context "when customer exists" do
      let(:customer) { create(:customer, orders_count: 1) }

      it "increments the customer's orders_count" do
        described_class.new(payload, logger: logger).call

        expect(customer.reload.orders_count).to eq(2)
        expect(logger).to have_received(:info).with("Incremented orders_count for customer ##{customer.id}")
      end
    end

    context "when customer does not exist" do
      let(:customer) { build(:customer) }

      it "logs a warning" do
        described_class.new(payload, logger: logger).call

        expect(logger).to have_received(:warn).with(/Customer .* not found/)
      end
    end
  end
end

