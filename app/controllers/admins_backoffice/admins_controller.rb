class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [:edit,:update]

  def index
    @admins = Admin.all
  end

  def new 
    @admin = Admin.new
  end

  def create
    @admin = Admin.new(params_admin)
    if @admin.save
      redirect_to admins_backoffice_admins_path, notice: "Adm included sucessfuly"
    elsif
      #renderizar de novo
      render :new
    end
  end

  def edit
  end
  
  def update
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Adm saved sucessfuly"
    elsif
      #renderizar de novo
      render :edit
    end
  end

  private
  
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end

end
