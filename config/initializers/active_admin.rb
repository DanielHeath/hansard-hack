ActiveAdmin.setup do |config|

  # == Site Title
  #
  # Set the title that is displayed on the main layout
  # for each of the active admin pages.
  #
  config.site_title = "Hansearch"
  config.authentication_method = false
  config.current_user_method   = false
  config.logout_link_path = :destroy_admin_user_session_path



end
