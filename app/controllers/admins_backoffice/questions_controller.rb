class AdminsBackoffice::QuestionsController < AdminsBackofficeController
    before_action :set_question, only: [:edit,:update, :destroy]
    before_action :set_subject_options, only: [:create, :new, :edit, :update] 

    def index
      @questions = Question.all.order(:id).page(params[:page])
    end
  
    def new 
      @question = Question.new
    end
  
    def create
      @question = Question.new(params_question)
      if @question.save
        redirect_to admins_backoffice_questions_path, notice: "Question included sucessfuly"
      elsif
        #renderizar de novo
        render :new
      end
    end
  
    def edit
    end
    
    def update
      if @question.update(params_question)
        redirect_to admins_backoffice_questions_path, notice: "Question saved sucessfuly"
      elsif
        #renderizar de novo
        render :edit
      end
    end
  
    def destroy
      if @question.destroy
        redirect_to admins_backoffice_questions_path, notice: "Question deleted sucessfuly"
      elsif
        #renderizar de novo
        render :index
      end
    end
  
    private

    def set_subject_options
        @subject_options = Subject.all.pluck(:description, :id)
      end
    
    def set_question
      @question = Question.find(params[:id])
    end
  
    def params_question
        params_question = params.require(:question).permit(:description, :subject_id)
    end
  
end
