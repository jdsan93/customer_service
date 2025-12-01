require 'rails_helper'

RSpec.describe "Customers API", type: :request do
  describe "GET /customers/:id" do
    context "when customer exists" do
      let!(:customer) { create(:customer, customer_name: "Acme", address: "123 Elm St", orders_count: 3) }

      it "returns customer data" do
        get "/customers/#{customer.id}"

        expect(response).to have_http_status(:ok)
        body = JSON.parse(response.body)
        expect(body).to include(
          "id" => customer.id,
          "customer_name" => "Acme",
          "address" => "123 Elm St",
          "orders_count" => 3
        )
      end
    end

    context "when customer does not exist" do
      it "returns not found" do
        get "/customers/999999"

        expect(response).to have_http_status(:not_found)
        expect(JSON.parse(response.body)).to eq("error" => "Customer not found")
      end
    end
  end
end

