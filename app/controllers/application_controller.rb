class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied. You are not authorized to access the requested page."
    redirect_to root_path and return
  end
 
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end 

  protected
 
  #derive the model name from the controller. egs UsersController will return User
  def self.permission
    return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
  end
 
  def current_ability
    @current_ability ||= Ability.new(current_user)
  end
 
  #load the permissions for the current user so that UI can be manipulated
  def load_permissions
    @current_permissions = current_user.role.permissions.collect{|i| [i.subject_class, i.action]}
  end
end
