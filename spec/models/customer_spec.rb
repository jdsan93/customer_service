require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "is valid with required attributes" do
    expect(build(:customer)).to be_valid
  end

  it "requires customer_name" do
    expect(build(:customer, customer_name: nil)).not_to be_valid
  end

  it "requires address" do
    expect(build(:customer, address: nil)).not_to be_valid
  end

  it "requires non-negative orders_count" do
    expect(build(:customer, orders_count: -1)).not_to be_valid
  end
end
require 'rails_helper'

RSpec.describe Customer, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
