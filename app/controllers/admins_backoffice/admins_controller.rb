class AdminsBackoffice::AdminsController < AdminsBackofficeController
  before_action :set_admin, only: [:edit,:update, :destroy]
  # before_action :verify_password, only: [:update]

  def index
    #console (like a break point. enable web console do debug application)
    @admins = Admin.all.page(params[:page])
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

  def destroy
    if @admin.destroy
      redirect_to admins_backoffice_admins_path, notice: "Adm deleted sucessfuly"
    elsif
      #renderizar de novo
      render :index
    end
  end

  private
  
  def set_admin
    @admin = Admin.find(params[:id])
  end

  def params_admin
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
  end

  def verify_password
    #não obrigar a informar senha e confirmação ao atualizar admin
    if params[:admin][:password].blank? && params[:admin][:password_confirmation].blank?
      params[:admin].extract!(:password, :password_confirmation)
    end
  end

end
