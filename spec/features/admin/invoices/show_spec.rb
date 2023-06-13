require "rails_helper"
require "application_helper"

RSpec.describe "Admin Invoices Show Page" do
  before(:each) do
    @customer1 = create(:customer)
    @customer2 = create(:customer)

    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)

    @coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 1)
    @coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 1, value: 15, coupon_type: 0)

    @invoice_1 = create(:invoice, customer_id: @customer1.id, coupon_id: @coupon_1.id)
    @invoice_2 = create(:invoice, customer_id: @customer2.id)

    @item_1 = create(:item, merchant_id: @merchant_1.id)
    @item_2 = create(:item, merchant_id: @merchant_1.id)
    @item_3 = create(:item, merchant_id: @merchant_1.id)
    @item_4 = create(:item, merchant_id: @merchant_2.id)
    @item_5 = create(:item, merchant_id: @merchant_2.id)

    @invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id)
    @invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id)
    @invoice_item_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id)
    @invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id)
    @invoice_item_5 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_5.id)
  end

  describe "As an admin" do
    it "displays information for a single invoice" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Invoice #{@invoice_1.id}")

      expect(page).to_not have_content(@invoice_2.id)
      # expect(page).to_not have_content(@invoice_2.status)
      # expect(page).to_not have_content(@invoice_2.formatted_time)
      expect(page).to_not have_content(@invoice_2.customer.first_name)
      expect(page).to_not have_content(@invoice_2.customer.last_name)

      within("#invoice_info") do
        expect(page).to have_content("#{@invoice_1.status}")
        expect(page).to have_content("Created on: #{@invoice_1.created_at.to_datetime.strftime("%A, %B %d, %Y")}")
        expect(page).to have_content("Customer: #{@invoice_1.customer.first_name} #{@invoice_1.customer.last_name}")

        expect(page).to_not have_content(@invoice_2.id)
        expect(page).to_not have_content(@invoice_2.customer.first_name)
        expect(page).to_not have_content(@invoice_2.customer.last_name)
      end
    end

    it "displays all items on the invoice" do
      visit admin_invoice_path(@invoice_1)

      within("#item_table") do
        expect(page).to have_content("Items on Invoice")
        expect(page).to have_content("#{@invoice_1.items[0].name}")
        expect(page).to have_content("#{@invoice_1.items[1].name}")
        expect(page).to have_content("#{@invoice_1.items[2].name}")

        expect(page).to_not have_content("#{@invoice_2.items[0].name}")
        expect(page).to_not have_content("#{@invoice_2.items[1].name}")

        expect(page).to have_content("#{@invoice_item_1.quantity}")
        expect(page).to have_content("#{@invoice_item_2.quantity}")
        expect(page).to have_content("#{@invoice_item_3.quantity}")

        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_1.unit_price)}")
        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_2.unit_price)}")
        expect(page).to have_content("$#{sprintf('%.2f', @invoice_item_3.unit_price)}")

        expect(page).to_not have_content("$#{sprintf('%.2f', @invoice_item_4.unit_price)}")
        expect(page).to_not have_content("$#{sprintf('%.2f', @invoice_item_5.unit_price)}")

        expect(page).to have_content("#{@invoice_item_1.status}")
        expect(page).to have_content("#{@invoice_item_2.status}")
        expect(page).to have_content("#{@invoice_item_3.status}")
      end
    end

    it "displays the total revenue for an invoice" do
      visit admin_invoice_path(@invoice_1)
      within("#invoice_info") do
        expect(page).to have_content("Subtotal: $#{sprintf('%.2f', @invoice_1.revenue)}")
      end

      visit admin_invoice_path(@invoice_2)

      within("#invoice_info") do
        expect(page).to have_content("Subtotal: $#{sprintf('%.2f', @invoice_2.revenue)}")
      end
    end

    it "displays the coupon used and discounted grand total" do
      visit admin_invoice_path(@invoice_1)

      expect(page).to have_content("Grand Total (including discounts if applicable): $#{sprintf('%.2f', @invoice_1.grand_total)}")
      expect(page).to have_content("Coupon Used: #{@coupon_1.name} #{@coupon_1.code}")
      expect(page).to_not have_content("Coupon Used: #{@coupon_2.name} #{@coupon_2.code}")
    end

    it "displays no coupon used when no coupon was applied to an invoice" do
      visit admin_invoice_path(@invoice_2)

      expect(page).to have_content("Grand Total (including discounts if applicable): $#{sprintf('%.2f', @invoice_2.grand_total)}")
      expect(page).to have_content("Coupon Used: No Coupon Used")
      expect(page).to_not have_content("Coupon Used: #{@coupon_1.name} #{@coupon_1.code}")
      expect(page).to_not have_content("Coupon Used: #{@coupon_2.name} #{@coupon_2.code}")
    end

    describe "Admin Invoice Show Page - Update Invoice Status" do
      it "displays a select field to update the invoice status" do
        visit admin_invoice_path(@invoice_1)

        within "#invoice_info" do
          expect(page).to have_select("status", selected: "#{@invoice_1[:status]}")
          expect(page).to have_button("Update Status")
        end
      end

      it "updates the invoice status when a new status is selected" do
        visit admin_invoice_path(@invoice_1)

        within "#invoice-status" do
          select "cancelled", from: "status"
          click_button "Update Status"
        end

        @invoice_1.reload
        expect(current_path).to eq(admin_invoice_path(@invoice_1))
        expect(@invoice_1.status).to eq("cancelled")
      end
    end
  end
end
