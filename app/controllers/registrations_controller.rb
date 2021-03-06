class RegistrationsController < Devise::RegistrationsController


  protected


  def after_sign_up_path_for(resource)
    create_temp_site_url(:subdomain => resource.subdomain)
  end

  

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def after_update_path_for(resource)
	  root_url(:subdomain => resource.subdomain)
	end

end