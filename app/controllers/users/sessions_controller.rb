# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  #The only reason this file is here is to set the flash[] message type to :success instead of the default :notice.

  # POST /resource/sign_in
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:success, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :success, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end
end
