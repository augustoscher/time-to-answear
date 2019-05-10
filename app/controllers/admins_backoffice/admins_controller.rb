class AdminsBackoffice::AdminsController < AdminsBackofficeController
  def index
    @admins = Admin.all
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def update
    @admin = Admin.find(params[:id])
    params_admin = params.require(:admin).permit(:email, :password, :password_confirmation)
    if @admin.update(params_admin)
      redirect_to admins_backoffice_admins_path, notice: "Adm saved sucessfuly"
    elsif
      #renderizar de novo
      render :edit
    end
  end

end
