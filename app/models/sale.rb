class Sale < ApplicationRecord
  belongs_to :visitor
  has_many :items
end
