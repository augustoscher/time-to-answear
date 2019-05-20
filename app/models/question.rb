class Question < ApplicationRecord
  belongs_to :subject, inverse_of: :questions
  has_many :answers
  accepts_nested_attributes_for :answers, reject_if: :all_blank, allow_destroy: true

  #kaminari
  paginates_per 5

  #usar full text search. 
  #like passa por cada registro da tabela, 
  #degradando a performance para tabelas onde existem muitos registros.
  #isso pode ser resolvido com um full text search.

  #scopes são pesquisas no banco de dados. Retorna sempre um ActiveRelation
  scope :_search_, ->(page, term){
    includes(:answers)
    .where("lower(description) LIKE ?", "%#{term.downcase}%")
    .page(page)
  }

  scope :last_questions, ->(page){
    includes(:answers)
    .order('created_at desc')
    .page(page)
  }
end
