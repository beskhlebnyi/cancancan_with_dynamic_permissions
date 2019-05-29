class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :admin_only, :except => :show
  

  def index
    @admins = Admin.all
  end

  def show
    @admin = Admin.find(params[:id])
    unless current_admin.admin?
      unless @admin == current_admin
        redirect_to root_path, :alert => "Access denied."
      end
    end
  end

  def update
    @admin = Admin.find(params[:id])
    if @admin.update_attributes(secure_params)
      redirect_to admins_path, :notice => "Admin updated."
    else
      redirect_to admins_path, :alert => "Unable to update admin."
    end
  end

  def destroy
    admin = Admin.find(params[:id])
    admin.destroy
    redirect_to admins_path, :notice => "Admin deleted."
  end

  private

  def admin_only
    unless current_admin.admin?
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:admin).permit(:role)
  end
end
