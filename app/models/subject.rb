class Subject < ApplicationRecord
  has_many :questions

  #kaminari
  paginates_per 5
end
