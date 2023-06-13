require "rails_helper"

RSpec.describe "Coupons Show Page" do
  before(:each) do
    @merchant_1 = create(:merchant)
    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 1)
    @coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 1)
    @customer_1 = create(:customer)

    @invoice_1 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_2 = create(:invoice, status: 2, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_3 = create(:invoice, status: 0, coupon_id: @coupon_1.id, customer_id: @customer_1.id)
    @invoice_4 = create(:invoice, status: 1, coupon_id: @coupon_2.id, customer_id: @customer_1.id)

    @transaction_1 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
    @transaction_2 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
    @transaction_3 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
    @transaction_4 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
    @transaction_5 = Transaction.create!(credit_card_number: 9876987698769876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_3.id, result: 1)
    @transaction_6 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 0)
    @transaction_7 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 1)
    @transaction_8 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 0)
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

      expect(page).to_not have_content("Coupon Name: #{@coupon_2.name}")
      expect(page).to_not have_content("Code: #{@coupon_2.code}")
    end

    it "has a button to disable the coupon" do
      @coupon_1.update(status: 1)
      visit merchant_coupon_path(@merchant_1, @coupon_1)

      expect(page).to have_content("Status: activated")
      expect(page).to have_button("Disable Coupon")

      click_button "Disable Coupon"

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_1))
      expect(page).to have_content("Status: disabled")
      expect(page).to have_button("Activate Coupon")
    end

    it "has a button to activate the coupon" do
      visit merchant_coupon_path(@merchant_1, @coupon_2)

      expect(page).to have_content("Status: disabled")
      expect(page).to have_button("Activate Coupon")

      click_button "Activate Coupon"

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_2))
      expect(page).to have_content("Status: activated")
      expect(page).to have_button("Disable Coupon")
    end

    it "flashes an error if you try to activate a coupon when you already have 5 activated" do
      @coupon_3 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 1, value: 10, coupon_type: 1)
      @coupon_4 = @merchant_1.coupons.create!(code: "5OFF", name: "Spring Sale", status: 1, value: 5, coupon_type: 1)
      @coupon_5 = @merchant_1.coupons.create!(code: "25OFF", name: "Black Friday", status: 1, value: 25, coupon_type: 1)
      @coupon_6 = @merchant_1.coupons.create!(code: "30OFF", name: "Cyber Monday", status: 1, value: 30, coupon_type: 0)
      @coupon_7 = @merchant_1.coupons.create!(code: "35OFF", name: "Christmas", status: 0, value: 35, coupon_type: 0)
      visit merchant_coupon_path(@merchant_1, @coupon_7)

      expect(page).to have_content("Status: disabled")
      expect(page).to have_button("Activate Coupon")

      click_button "Activate Coupon"

      expect(current_path).to eq(merchant_coupon_path(@merchant_1, @coupon_7))
      expect(page).to have_content("Status: disabled")
      expect(page).to have_content("You can only have 5 coupons activated at a time")
    end
  end
end