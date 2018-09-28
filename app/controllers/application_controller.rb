class ApplicationController < ActionController::Base
	require 'securerandom'
	before_action :configure_permitted_parameters, if: :devise_controller?
	#before_action :check_subdomain
	before_filter :redirect_subdomain

	def redirect_subdomain
	  if request.host == '2min.co'
	    redirect_to 'http://www.2min.co' + request.fullpath, :status => 301
	  end
	end

	def check_subdomain
      @host = request.host
      @host = @host.sub(/^www./,'')
      @found_user = User.where(domain: @host).last
      if @found_user.present?
      	  Apartment::Tenant.switch!(@found_user.subdomain)
          redirect_to sites_url(:subdomain => request.subdomain)
      else
      	redirect_to root_path
      end   
	end

	protected
		def after_sign_in_path_for(resource)
		  sites_url(:subdomain => resource.subdomain)
		end

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.permit(:sign_up, keys: [:subdomain, :domain])
	  end

	 
	
end
