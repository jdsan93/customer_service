customers = [
  { customer_name: "Acme Corp", address: "742 Evergreen Terrace, Springfield" },
  { customer_name: "Globex", address: "123 Market Street, Shelbyville" },
  { customer_name: "Initech", address: "1 Silicon Way, Palo Alto" }
]

customers.each do |attrs|
  Customer.find_or_create_by!(customer_name: attrs[:customer_name]) do |customer|
    customer.address = attrs[:address]
  end
end
