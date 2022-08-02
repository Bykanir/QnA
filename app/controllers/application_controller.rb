# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :gon_user

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
  end

  check_authorization

  private

  def gon_user
    gon.current_user = current_user.id if current_user
  end
end
