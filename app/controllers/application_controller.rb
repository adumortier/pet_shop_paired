class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites

  def favorites
    session[:fav_pets] ||= Hash.new(0)
    @favorites ||= Favorite.new(session[:fav_pets])
    # require "pry"; binding.pry
  end
end
