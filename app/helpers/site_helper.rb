module SiteHelper

  def msg_questions
    case params[:action]
    when 'index'
      "Last added questions..."
    when 'subject'
      "Questions of subject \"#{params[:subject]}\""
    when 'questions'
      "Results for \"#{params[:term]}\""
    end
  end

end
