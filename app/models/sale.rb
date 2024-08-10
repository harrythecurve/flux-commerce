class Sale < ApplicationRecord
  belongs_to :visitor
  belongs_to :item
end
