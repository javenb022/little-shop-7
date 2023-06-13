class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices
  has_many :transactions, through: :invoices

  validates_presence_of :name, :code, :status, :coupon_type
  validates :code, uniqueness: { case_sensitive: false }
  validates :value, numericality: true


  enum status: {"disabled": 0, "activated": 1}
  enum coupon_type: {"percent": 0, "dollar": 1}

  def uses
    transactions.where(result: 0, invoices: {coupon_id: self.id}).count
  end

  def self.activated_coupons
    self.where(status: 1)
  end

  def self.disabled_coupons
    self.where(status: 0)
  end

  def self.five_coupons_activated?
    self.all.where(status: 1).count == 5
  end
end