class Rating < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :drink

  validates :score, inclusion: { in: %w(nil 1 -1) }
end
