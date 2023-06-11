class Coupon < ApplicationRecord
  belongs_to :merchant
  has_many :invoices

  validates_presence_of :name, :code, :status, :coupon_type
  validates :code, uniqueness: { case_sensitive: false }
  validates :value, numericality: true


  enum status: {"disabled": 0, "activated": 1}
  enum coupon_type: {"percent": 0, "dollar": 1}
end