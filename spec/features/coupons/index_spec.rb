require "rails_helper"

RSpec.describe "Coupons Index Page" do
  before(:each) do
    @merchant_1 = create(:merchant)

    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 0)
    @coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 0)
    @coupon_3 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 0, value: 10, coupon_type: 1)
    @coupon_4 = @merchant_1.coupons.create!(code: "5OFF", name: "Spring Sale", status: 1, value: 5, coupon_type: 0)
    @coupon_5 = @merchant_1.coupons.create!(code: "25OFF", name: "Black Friday", status: 0, value: 25, coupon_type: 1)
  end

  describe "As a Merchant" do
    it "shows all coupons names and amount off, separated by status" do
      visit merchant_coupons_path(@merchant_1)

      within "#activated-coupons" do
        expect(page).to have_content("Activated Coupons")
        expect(page).to have_link("#{@coupon_1.name}")
        expect(page).to have_content("#{@coupon_1.value} percent Off!")
        expect(page).to have_link("#{@coupon_4.name}")
        expect(page).to have_content("#{@coupon_4.value} percent Off!")

        expect(page).to_not have_link("#{@coupon_2.name}")
        expect(page).to_not have_content("#{@coupon_2.value} percent Off!")
        expect(page).to_not have_link("#{@coupon_3.name}")
        expect(page).to_not have_content("#{@coupon_3.value} dollar Off!")
        expect(page).to_not have_link("#{@coupon_5.name}")
        expect(page).to_not have_content("#{@coupon_5.value} dollar Off!")
      end

      within "#disabled-coupons" do
        expect(page).to have_content("Disabled Coupons")
        expect(page).to have_link("#{@coupon_2.name}")
        expect(page).to have_content("#{@coupon_2.value} percent Off!")
        expect(page).to have_link("#{@coupon_3.name}")
        expect(page).to have_content("#{@coupon_3.value} dollar Off!")
        expect(page).to have_link("#{@coupon_5.name}")
        expect(page).to have_content("#{@coupon_5.value} dollar Off!")

        expect(page).to_not have_content("Activated Coupons")
        expect(page).to_not have_link("#{@coupon_1.name}")
        expect(page).to_not have_content("#{@coupon_1.value} percent Off!")
        expect(page).to_not have_link("#{@coupon_4.name}")
      end
    end

    it "shows a link to create a new coupon" do
      visit merchant_coupons_path(@merchant_1)

      expect(page).to have_link("Create New Coupon")

      click_link "Create New Coupon"

      expect(current_path).to eq(new_merchant_coupon_path(@merchant_1))
    end
  end
end