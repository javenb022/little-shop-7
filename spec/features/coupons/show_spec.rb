require "rails_helper"

RSpec.describe "Coupons Show Page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 0, value: 20, coupon_type: 1)
    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, status: 0, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, status: 1, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
  end
  describe "as a merchant" do
    it "shows the coupon name, code, amount off, status, and number of times it's been used" do
      visit merchant_coupon_path(@merchant_1, @coupon_1)

      expect(page).to have_content("Coupon Name: #{@coupon_1.name}")
      expect(page).to have_content("Code: #{@coupon_1.code}")
      expect(page).to have_content("Value: #{@coupon_1.value}")
      expect(page).to have_content("Coupon Type: #{@coupon_1.coupon_type}")
      expect(page).to have_content("Status: #{@coupon_1.status}")
      expect(page).to have_content("Times Used: #{@coupon_1.uses}")
    end
  end
end