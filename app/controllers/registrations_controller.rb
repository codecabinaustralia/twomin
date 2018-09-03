class RegistrationsController < Devise::RegistrationsController
  protected


  def after_sign_up_path_for(resource)
    tenant_url(:subdomain => resource.subdomain)
  end

  def after_update_path_for(resource)
	  root_url(:subdomain => resource.subdomain)
	end

end