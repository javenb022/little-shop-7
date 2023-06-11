require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant)
    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 0, value: 20, coupon_type: 1)
    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, status: 0, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, status: 1, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
  end
  describe "validations" do
    subject { FactoryBot.build(:coupon, merchant_id: @merchant_1.id, status: 1, coupon_type: 0) }
    it { should belong_to :merchant }
    it { should have_many :invoices }
    it { should validate_presence_of :name }
    it { should validate_presence_of :code }
    it { should validate_uniqueness_of(:code).case_insensitive }
    it { should validate_presence_of(:status) }
    it { should validate_numericality_of(:value) }
    it { should validate_presence_of(:coupon_type) }
    it { should define_enum_for(:status).with_values([:disabled, :activated]) }
    it { should define_enum_for(:coupon_type).with_values([:percent, :dollar]) }
  end

  describe "instance methods" do
    describe "#uses" do
      it "returns the number of times a coupon has been used" do
        @coupon_2 = @merchant_1.coupons.create!(code: "25OFF", name: "Winter Sale", status: 1, value: 25, coupon_type: 1)
        @customer_2 = create(:customer)

        @invoice_5 = create(:invoice, status: 0, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
        @invoice_6 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
        @invoice_7 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
        @invoice_8 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)

        expect(@coupon_1.uses).to eq(2)
        expect(@coupon_2.uses).to eq(3)
      end
    end
  end
end
