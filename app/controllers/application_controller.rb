class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges,
  # import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  protected

  # After a user signs in
  def after_sign_in_path_for(resource)
    friends_path
  end

  # After a user signs up
  def after_sign_up_path_for(resource)
    edit_user_registration_path
  end

  # After a user signs out
  def after_sign_out_path_for(resource_or_scope)
    new_user_session_path
  end
end