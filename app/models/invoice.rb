class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  belongs_to :coupon, optional: true

  validates_presence_of :status

  enum status: ["cancelled", "completed", "in progress"] # can = 0 com = 1 in p = 2

  #class methods
  def self.incomp_invoices
    Invoice.joins(:invoice_items).where("invoice_items.status != ?", 1).order(created_at: :asc, id: :asc).distinct
  end

  def grand_total
    subtotal = revenue
    if coupon.present? && coupon.activated?
      revenue - coupon_discount(subtotal)
    else
      revenue
    end
  end

  def coupon_discount(subtotal)
    if coupon.percent?
      subtotal * (coupon.value / 100.0)
    else
      coupon.value
    end
  end

  #instance methods
  def revenue
    invoice_items.sum("unit_price * quantity")
  end
end
