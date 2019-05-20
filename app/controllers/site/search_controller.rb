class Site::SearchController < SiteController
  def questions
    #usar full text search. 
    #like passa por cada registro da tabela, 
    #degradando a performance para tabelas onde existem muitos registros.
    #isso pode ser resolvido com um full text search.
    @questions = Question.includes(:answers)
      .where("lower(description) LIKE ?", "%#{params[:term].downcase}%")
      .page(params[:page])
  end
end
