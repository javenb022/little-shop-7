class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice

  enum status: ["packaged", "shipped", "pending"] # pack = 0 ship = 1 pen = 2 need to remigrate and make status an integer
end