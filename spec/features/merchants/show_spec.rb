require "rails_helper"

RSpec.describe "/merchants/:id/dashboard" do
  describe "As a visitor" do
    describe "when I visit a merchants show page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_2) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_3) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_4) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_5) { create(:item, merchant_id: merchant_1.id) }
      let!(:item_6) { create(:item, merchant_id: merchant_2.id) }

      let!(:transaction_1) { create(:transaction, invoice_id: invoice_1.id, result: 0) }
      let!(:transaction_2) { create(:transaction, invoice_id: invoice_2.id, result: 0) }
      let!(:transaction_3) { create(:transaction, invoice_id: invoice_3.id, result: 0) }
      let!(:transaction_4) { create(:transaction, invoice_id: invoice_4.id, result: 0) }
      let!(:transaction_5) { create(:transaction, invoice_id: invoice_5.id, result: 0) }
      let!(:transaction_6) { create(:transaction, invoice_id: invoice_5.id, result: 0) }
      let!(:transaction_7) { create(:transaction, invoice_id: invoice_5.id, result: 1) }

      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 0)}
      let!(:invoice_2) { create(:invoice, customer_id: customer_2.id, status: 0)}
      let!(:invoice_3) { create(:invoice, customer_id: customer_3.id, status: 0)}
      let!(:invoice_4) { create(:invoice, customer_id: customer_4.id, status: 0)}
      let!(:invoice_5) { create(:invoice, customer_id: customer_5.id, status: 0)}

      let!(:invoice_item_1) { create(:invoice_item, unit_price: 2000, status: 2, invoice_id: invoice_1.id, item_id: item_1.id) }
      let!(:invoice_item_2) { create(:invoice_item, unit_price: 3000, status: 2, invoice_id: invoice_2.id, item_id: item_2.id) }
      let!(:invoice_item_3) { create(:invoice_item, unit_price: 4000, status: 2, invoice_id: invoice_3.id, item_id: item_3.id) }
      let!(:invoice_item_4) { create(:invoice_item, unit_price: 5000, status: 1, invoice_id: invoice_4.id, item_id: item_4.id) }
      let!(:invoice_item_5) { create(:invoice_item, unit_price: 5000, status: 1, invoice_id: invoice_5.id, item_id: item_5.id) }

      let!(:customer_1) { create(:customer) }
      let!(:customer_2) { create(:customer) }
      let!(:customer_3) { create(:customer) }
      let!(:customer_4) { create(:customer) }
      let!(:customer_5) { create(:customer) }
      let!(:customer_6) { create(:customer) }
      let!(:customer_7) { create(:customer) }

      # User Story 1

      it "directs me to the merchants dashboard where I see the merchants name" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content(merchant_1.name)
        expect(page).to_not have_content(merchant_2.name)

        visit "/merchants/#{merchant_2.id}/dashboard"
        expect(page).to have_content(merchant_2.name)
        expect(page).to_not have_content(merchant_1.name)
      end

      # 2. Merchant Dashboard Links

      it "links to the merchants items index" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/items")
        expect(page).to have_content("#{merchant_1.name} Items")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Items"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/items")
        expect(page).to have_content("#{merchant_2.name} Items")
      end

      it "links to the merchants invoices index" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/invoices")
        expect(page).to have_content("#{merchant_1.name} Invoices")

        visit "/merchants/#{merchant_2.id}/dashboard"
        click_link "My Invoices"
        expect(current_path).to eq("/merchants/#{merchant_2.id}/invoices")
        expect(page).to have_content("#{merchant_2.name} Invoices")
      end
      # 3. Merchant Dashboard Statistics - Favorite Customers

      it "see top 5 customers on on dashboard" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content("Top 5 Customers")
        expect(page).to have_content(customer_1.first_name)
        expect(page).to have_content(customer_2.first_name)
        expect(page).to have_content(customer_3.first_name)
        expect(page).to have_content(customer_4.first_name)
        expect(page).to have_content(customer_5.first_name)
        expect(page).not_to have_content(customer_6.first_name)
        expect(page).not_to have_content(customer_7.first_name)
      end


        #         4. Merchant Dashboard Items Ready to Ship.
        # As a merchant
        # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
        # Then I see a section for "Items Ready to Ship"
        # In that section I see a list of the names of all of my items that
        # have been ordered and have not yet been shipped,
        # And next to each Item I see the id of the invoice that ordered my item
        # And each invoice id is a link to my merchant's invoice show page
      it "shows section for 'Items Ready to Ship'" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        expect(page).to have_content("Items Ready to Ship")
      end
      it "shows list of names of all items ordered but not shipped in 'Items Ready to ship'" do
        visit "/merchants/#{merchant_1.id}/dashboard"
        pending_items = [item_1.name, item_2.name, item_3.name]
        expect(page).to have_content(pending_items)

      end
      it "shows invoice id next to items not shipped with link to merchants invoice show page" do
        visit "/merchants/#{merchant_1.id}/dashboard"

      end
    end
  end
end
