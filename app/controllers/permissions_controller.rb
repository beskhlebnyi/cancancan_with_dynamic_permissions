class PermissionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @permission = Permission.new(params.permit(:name, :subject_class, :action))

    respond_to do |format|
      if @permission.save
        #format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render json: @permission, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @permission.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @permission = Permission.find(params[:id])
    if @permission.destroy
      
      respond_to do |format|
        format.json { render json: @permission, :status => :ok}
      end
    else
      
      redirect_to permissions_url
    end
  end
  

end