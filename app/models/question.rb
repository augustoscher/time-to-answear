class Question < ApplicationRecord
  belongs_to :subject

  #kaminari
  paginates_per 5
end
