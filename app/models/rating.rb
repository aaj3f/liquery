class Rating < ApplicationRecord
  belongs_to :rating, optional: true
  belongs_to :user, optional: true
  belongs_to :drink
end
