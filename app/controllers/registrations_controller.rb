class RegistrationsController < Devise::RegistrationsController

  def after_sign_out_path_for(resource_or_scope)
    new_user_registration_path
  end

  def after_sign_up_path_for(resource)
    root_path
  end
end