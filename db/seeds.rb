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

@customer1 = Customer.create!(first_name: "Bob", last_name: "Gu")
@customer2 = Customer.create!(first_name: "Sally", last_name: "Shopper")

@merchant_1 = Merchant.create!(name: "Hair Care")
@merchant_2 = Merchant.create!(name: "Body Care")

@coupon_1 = @merchant_1.coupons.create!(code: "20OFF", name: "Summer Sale", status: 1, value: 20, coupon_type: 0)
@coupon_2 = @merchant_1.coupons.create!(code: "15OFF", name: "Winter Sale", status: 0, value: 15, coupon_type: 0)
@coupon_3 = @merchant_1.coupons.create!(code: "10OFF", name: "Fall Sale", status: 0, value: 10, coupon_type: 1)
@coupon_4 = @merchant_2.coupons.create!(code: "5OFF", name: "Spring Sale", status: 1, value: 5, coupon_type: 0)
@coupon_5 = @merchant_2.coupons.create!(code: "25OFF", name: "Black Friday", status: 0, value: 25, coupon_type: 1)
@coupon_6 = @merchant_2.coupons.create!(code: "30OFF", name: "Cyber Monday", status: 0, value: 30, coupon_type: 0)

@invoice_1 = Invoice.create!(status: 1, customer_id: @customer1.id, coupon_id: @coupon_1.id)
@invoice_2 = Invoice.create!(status: 1, customer_id: @customer1.id, coupon_id: @coupon_2.id)
@invoice_3 = Invoice.create!(status: 0, customer_id: @customer2.id, coupon_id: @coupon_2.id)
@invoice_4 = Invoice.create!(status: 1, customer_id: @customer2.id, coupon_id: @coupon_1.id)
@invoice_5 = Invoice.create!(status: 1, customer_id: @customer2.id)

@item_1 = Item.create!(name: "Shampoo", description: "Cleans your hair", merchant_id: @merchant_1.id, status: 1, unit_price: 100)
@item_2 = Item.create!(name: "Conditioner", description: "Conditions your hair", merchant_id: @merchant_1.id, status: 1, unit_price: 100)
@item_3 = Item.create!(name: "Brush", description: "Brushes your hair", merchant_id: @merchant_1.id, status: 1, unit_price: 100)
@item_4 = Item.create!(name: "Soap", description: "Cleans your body", merchant_id: @merchant_2.id, status: 1, unit_price: 100)
@item_5 = Item.create!(name: "Lotion", description: "Moisturizes your body", merchant_id: @merchant_2.id, status: 1, unit_price: 100)

@invoice_item_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_2 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_2.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_3 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_3.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_4 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_4.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_5 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_5.id, quantity: 2, unit_price: 100, status: 1)
@invoice_item_6 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_1.id, quantity: 2, unit_price: 100, status: 1)

@transaction_1 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
@transaction_2 = Transaction.create!(credit_card_number: 1234123498765432, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_1.id, result: 0)
@transaction_3 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
@transaction_4 = Transaction.create!(credit_card_number: 1234123412341234, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_2.id, result: 0)
@transaction_5 = Transaction.create!(credit_card_number: 9876987698769876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_3.id, result: 1)
@transaction_6 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 0)
@transaction_7 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 1)
@transaction_8 = Transaction.create!(credit_card_number: 1234987612349876, credit_card_expiration_date: 01/01/2026, invoice_id: @invoice_4.id, result: 0)