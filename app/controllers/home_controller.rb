# frozen_string_literal: true

# Home Controller Class
class HomeController < ApplicationController
  # GET /
  def index
    session[:chat_rooms] ||= []

    @users = User.all.where.not(id: current_user)
    @chat_rooms = ChatRoom.includes(:recipient, :messages).find(session[:chat_rooms])
  end
end
