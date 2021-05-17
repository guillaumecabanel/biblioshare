class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def display_menu?
    !controller_name.include?('step') && \
    !controller_name.include?('settings') && \
    !action_name.include?('new')
  end
  helper_method :display_menu?

end
