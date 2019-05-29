class Ability
  include CanCan::Ability

  def initialize(admin)
    admin.role.permissions.each do |permission|
      if permission.subject_class == "all"
        if permission.name = "can"
          can permission.action.to_sym, permission.subject_class.to_sym  
        elsif permission.name = "cannot"
          cannot permission.action.to_sym, permission.subject_class.to_sym
        end  
      else
        if permission.name = 'can'
          can permission.action.to_sym, permission.subject_class.constantize 
        elsif  permission.name = 'cannot'
          cannot permission.action.to_sym, permission.subject_class.constantize
        end
      end
    end
  end
end
