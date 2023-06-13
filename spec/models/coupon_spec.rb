require 'rails_helper'

RSpec.describe Coupon, type: :model do
  before(:each) do
    @merchant_1 = create(:merchant)
    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 0, value: 20, coupon_type: 1)
    @coupon_2 = @merchant_1.coupons.create!(code: "25DOFF", name: "Winter Sale", status: 1, value: 25, coupon_type: 1)
    @coupon_3 = @merchant_1.coupons.create!(code: "20POFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 0)
    @coupon_4 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 0)
    @coupon_5 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 0, value: 10, coupon_type: 1)
    @coupon_6 = @merchant_1.coupons.create!(code: "5OFF", name: "Spring Sale", status: 1, value: 5, coupon_type: 0)
    @coupon_7 = @merchant_1.coupons.create!(code: "25OFF", name: "Black Friday", status: 0, value: 25, coupon_type: 1)

    @customer_1 = create(:customer)
    @customer_2 = create(:customer)

    @invoice_1 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, status: 0, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, status: 1, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_5 = create(:invoice, status: 0, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
    @invoice_6 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
    @invoice_7 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)
    @invoice_8 = create(:invoice, status: 2, coupon_id: @coupon_2.id, customer_id: @customer_2.id)

    @transaction_1 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
    @transaction_2 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
    @transaction_3 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
    @transaction_4 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
    @transaction_5 = Transaction.create!(credit_card_number: 9876987698769876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_3.id, result: 1)
    @transaction_6 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 0)
    @transaction_7 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_5.id, result: 1)
    @transaction_8 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_6.id, result: 0)
    @transaction_9 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_7.id, result: 0)
    @transaction_10 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_8.id, result: 0)
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

  describe "class methods" do
    describe "#uses" do
      it "returns the number of times a coupon has been used" do


        expect(@coupon_1.uses).to eq(5)
        expect(@coupon_2.uses).to eq(3)
      end

      it "sorts coupons by activated" do
        expect(Coupon.activated_coupons).to eq([@coupon_2, @coupon_3, @coupon_6])
      end

      it "sorts coupons by disabled" do
        expect(Coupon.disabled_coupons).to eq([@coupon_1, @coupon_4, @coupon_5, @coupon_7])
      end

      it "checks if there are 5 coupons activated" do
        expect(Coupon.five_coupons_activated?).to eq(false)

        @coupon_10 = @merchant_1.coupons.create!(code: "25BOFF", name: "Black Friday", status: 1, value: 25, coupon_type: 1)
        @coupon_11 = @merchant_1.coupons.create!(code: "30POFF", name: "Cyber Monday", status: 1, value: 30, coupon_type: 0)
        @coupon_12 = @merchant_1.coupons.create!(code: "35POFF", name: "Christmas", status: 0, value: 35, coupon_type: 0)

        expect(Coupon.five_coupons_activated?).to eq(true)
      end
    end
  end
end
