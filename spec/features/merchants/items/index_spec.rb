require "rails_helper"

RSpec.describe "/merchants/:merchant_id/items" do
  describe "As a visitor" do
    describe "when I visit a merchants items index page" do
      let!(:merchant_1) { create(:merchant) }
      let!(:merchant_2) { create(:merchant) }

      let!(:customer_1) { create(:customer) }

      let!(:item_1) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_1) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_2) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_1) { create(:invoice_item, invoice: invoice_1, item: item_1, unit_price: 900000, quantity: 1) }
      let!(:invoice_item_2) { create(:invoice_item, invoice: invoice_2, item: item_1, unit_price: 900000, quantity: 1) }

      let!(:item_2) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_3) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_4) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_3) { create(:invoice_item, invoice: invoice_3, item: item_2, unit_price: 300000, quantity: 1) }
      let!(:invoice_item_4) { create(:invoice_item, invoice: invoice_4, item: item_2, unit_price: 300000, quantity: 1) }

      let!(:item_3) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_5) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_6) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_5) { create(:invoice_item, invoice: invoice_5, item: item_3, unit_price: 600000, quantity: 1) }
      let!(:invoice_item_6) { create(:invoice_item, invoice: invoice_6, item: item_3, unit_price: 600000, quantity: 1) }

      let!(:item_4) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_7) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_8) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_7) { create(:invoice_item, invoice: invoice_7, item: item_4, unit_price: 12, quantity: 1) }
      let!(:invoice_item_8) { create(:invoice_item, invoice: invoice_8, item: item_4, unit_price: 12, quantity: 1) }

      let!(:item_5) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_9) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_10) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_9) { create(:invoice_item, invoice: invoice_9, item: item_5, unit_price: 10000, quantity: 1) }
      let!(:invoice_item_10) { create(:invoice_item, invoice: invoice_10, item: item_5, unit_price: 10000, quantity: 1) }

      let!(:item_6) { create(:item, merchant_id: merchant_1.id, status: 1)}
      let!(:invoice_11) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_12) { create(:invoice, customer_id: customer_1.id, status: 1)}
      let!(:invoice_item_11) { create(:invoice_item, invoice: invoice_11, item: item_6, unit_price: 1200000, quantity: 1) }
      let!(:invoice_item_12) { create(:invoice_item, invoice: invoice_12, item: item_6, unit_price: 1200000, quantity: 1) }

      let!(:transaction_1) { create(:transaction, invoice: invoice_1, result: 0) }
      let!(:transaction_2) { create(:transaction, invoice: invoice_2, result: 0) }
      let!(:transaction_3) { create(:transaction, invoice: invoice_3, result: 0) }
      let!(:transaction_4) { create(:transaction, invoice: invoice_4, result: 0) }
      let!(:transaction_5) { create(:transaction, invoice: invoice_5, result: 0) }
      let!(:transaction_6) { create(:transaction, invoice: invoice_6, result: 0) }
      let!(:transaction_7) { create(:transaction, invoice: invoice_7, result: 0) }
      let!(:transaction_8) { create(:transaction, invoice: invoice_8, result: 0) }
      let!(:transaction_9) { create(:transaction, invoice: invoice_9, result: 0) }
      let!(:transaction_10) { create(:transaction, invoice: invoice_10, result: 0) }
      let!(:transaction_11) { create(:transaction, invoice: invoice_11, result: 0) }
      let!(:transaction_12) { create(:transaction, invoice: invoice_12, result: 0) }

      let!(:item_11) { create(:item, merchant_id: merchant_2.id, status: 0)}
      let!(:item_12) { create(:item, merchant_id: merchant_1.id, status: 0)}


      it "displays a list of names of all that merchants items" do
        visit merchant_items_path(merchant_1)

        within ".enabled-items" do
          expect(page).to have_content(item_1.name)
          expect(page).to have_content(item_2.name)
          expect(page).to have_content(item_3.name)
          expect(page).to have_content(item_4.name)
          expect(page).to have_content(item_5.name)
          expect(page).to_not have_content(item_11.name)
        end

        visit merchant_items_path(merchant_2)

        within ".disabled-items" do
          expect(page).to have_content(item_11.name)
          expect(page).to_not have_content(item_1.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_3.name)
          expect(page).to_not have_content(item_4.name)
          expect(page).to_not have_content(item_5.name)
        end
      end

      it "links to the items show page when I click on the item name" do
        visit merchant_items_path(merchant_1)

        within ".enabled-items" do
          click_link "#{item_1.name}"
        end

        expect(current_path).to eq(merchant_item_path(merchant_1, item_1))
        expect(current_path).to_not eq(merchant_item_path(merchant_1, item_2))

        visit merchant_items_path(merchant_1)

        within ".disabled-items" do
          click_link "#{item_12.name}"
        end
        expect(current_path).to eq(merchant_item_path(merchant_1, item_12))
      end

      it "displays a button that will enable or disable each item" do
        visit merchant_items_path(merchant_1)

        within ".enabled-items" do
          expect(page).to have_content("Enabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to have_link(item_2.name)
          expect(page).to have_link(item_3.name)

          expect(page).to have_button("Disable #{item_1.name}")
          expect(page).to have_button("Disable #{item_2.name}")
          expect(page).to have_button("Disable #{item_3.name}")

          click_button "Disable #{item_1.name}"
        end

        expect(current_path).to eq(merchant_items_path(merchant_1))

        within ".disabled-items" do
          expect(page).to have_content("Disabled Items")
          expect(page).to have_link(item_1.name)
          expect(page).to have_link(item_12.name)
          expect(page).to_not have_content(item_2.name)
          expect(page).to_not have_content(item_3.name)

          expect(page).to have_button("Enable #{item_1.name}")
          expect(page).to have_button("Enable #{item_12.name}")
          expect(page).to_not have_button("Disable #{item_2.name}")
          expect(page).to_not have_button("Disable #{item_3.name}")

          click_button "Enable #{item_12.name}"
        end

        within ".enabled-items" do
          expect(page).to_not have_link(item_1.name)
          expect(page).to_not have_button("Disable #{item_1.name}")

          expect(page).to have_link(item_12.name)
          expect(page).to have_button("Disable #{item_12.name}")
        end
      end

      it "has a link to create a new item" do
        visit merchant_items_path(merchant_1)

        click_link "Create New Item"
        expect(current_path).to eq(new_merchant_item_path(merchant_1))
      end

      it "displays the top 5 most popular items ranked by total revenue for the one merchant" do
        visit merchant_items_path(merchant_1)

        within ".top-five-items" do
          expect(page).to have_content("Top 5 Items")

          expect(item_6.name).to appear_before(item_1.name)
          expect(item_1.name).to appear_before(item_3.name)
          expect(item_3.name).to appear_before(item_2.name)
          expect(item_2.name).to appear_before(item_5.name)

          expect(page).to have_content("#{item_6.name} - $24,000.00 in sales")
          expect(page).to have_content("#{item_1.name} - $18,000.00 in sales")
          expect(page).to have_content("#{item_3.name} - $12,000.00 in sales")
          expect(page).to have_content("#{item_2.name} - $6,000.00 in sales")
          expect(page).to have_content("#{item_5.name} - $200.00 in sales")
          expect(page).to_not have_content("#{item_4.name} - $24.00 in sales")
        end
      end

      it "displays each name as a link in the top 5 merchants by revenue" do

        visit merchant_items_path(merchant_1)

        within ".top-five-items" do
          expect(page).to have_link("#{item_1.name}")
          expect(page).to have_link("#{item_2.name}")
          expect(page).to have_link("#{item_3.name}")
          expect(page).to have_link("#{item_5.name}")
          expect(page).to have_link("#{item_6.name}")

          expect(page).to_not have_link("#{item_4.name}")

          click_link("#{item_1.name}")
        end

        expect(current_path).to eq(merchant_item_path(merchant_1, item_1))
      end

      it "displays the date with most sales for each item next to each of the 5 most popular items" do

        visit merchant_items_path(merchant_1)

        within ".top-five-items" do
          expect(page).to have_content("Top selling date for #{item_6.name} was #{invoice_12.created_at.to_datetime.strftime("%Y-%m-%d")}")
          expect(page).to have_content("Top selling date for #{item_1.name} was #{invoice_2.created_at.to_datetime.strftime("%Y-%m-%d")}")
          expect(page).to have_content("Top selling date for #{item_3.name} was #{invoice_6.created_at.to_datetime.strftime("%Y-%m-%d")}")
          expect(page).to have_content("Top selling date for #{item_2.name} was #{invoice_4.created_at.to_datetime.strftime("%Y-%m-%d")}")
          expect(page).to have_content("Top selling date for #{item_5.name} was #{invoice_10.created_at.to_datetime.strftime("%Y-%m-%d")}")
        end
      end
    end
  end
end