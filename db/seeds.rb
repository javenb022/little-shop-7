# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
InvoiceItem.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Item.destroy_all
Coupon.destroy_all
Merchant.destroy_all
Customer.destroy_all
Rake::Task["csv_load:all"].invoke

@customer1 = create(:customer)
@customer2 = create(:customer)

@merchant_1 = create(:merchant)
@merchant_2 = create(:merchant)

@coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 0)
@coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 0)
@coupon_3 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 0, value: 10, coupon_type: 1)
@coupon_4 = @merchant_2.coupons.create!(code: "5OFF", name: "Spring Sale", status: 1, value: 5, coupon_type: 0)
@coupon_5 = @merchant_2.coupons.create!(code: "25OFF", name: "Black Friday", status: 0, value: 25, coupon_type: 1)
@coupon_6 = @merchant_2.coupons.create!(code: "30OFF", name: "Cyber Monday", status: 0, value: 30, coupon_type: 0)

@invoice_1 = create(:invoice, status: 1, customer_id: @customer1.id, coupon_id: @coupon_1.id)
@invoice_2 = create(:invoice, status: 1, customer_id: @customer2.id, coupon_id: @coupon_2.id)
@invoice_3 = create(:invoice, status: 0, customer_id: @customer2.id, coupon_id: @coupon_2.id)
@invoice_4 = create(:invoice, status: 1, customer_id: @customer2.id, coupon_id: @coupon_1.id)
@invoice_5 = create(:invoice, status: 1, customer_id: @customer2.id)

@item_1 = create(:item, merchant_id: @merchant_1.id)
@item_2 = create(:item, merchant_id: @merchant_1.id)
@item_3 = create(:item, merchant_id: @merchant_1.id)
@item_4 = create(:item, merchant_id: @merchant_2.id)
@item_5 = create(:item, merchant_id: @merchant_2.id)

@invoice_item_1 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_2 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_3 = create(:invoice_item, invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_4 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_4.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_5 = create(:invoice_item, invoice_id: @invoice_2.id, item_id: @item_5.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_6 = create(:invoice_item, invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 100, status: 1)

@transaction_1 = create(:transaction, invoice_id: @invoice_1.id, status: 0)
@transaction_2 = create(:transaction, invoice_id: @invoice_1.id, status: 0)
@transaction_3 = create(:transaction, invoice_id: @invoice_2.id, status: 0)
@transaction_4 = create(:transaction, invoice_id: @invoice_2.id, status: 0)
@transaction_5 = create(:transaction, invoice_id: @invoice_3.id, status: 1)
@transaction_6 = create(:transaction, invoice_id: @invoice_4.id, status: 0)
@transaction_7 = create(:transaction, invoice_id: @invoice_4.id, status: 1)
@transaction_8 = create(:transaction, invoice_id: @invoice_4.id, status: 0)