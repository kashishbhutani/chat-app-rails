# frozen_string_literal: true

# Application Controller Class
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protect_from_forgery with: :exception
end
