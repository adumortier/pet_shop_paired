class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites

  def favorites
    # init = {params[:id] => 0}
    # @favorites ||= Favorite.new(init)
    # session[:fav_pets] ||= params[:id]
    # init = {session[:fav_pets] => 0}
    # @favorites ||= Favorite.new(init)
    session[:fav_pets] ||= Hash.new(0)
    # session[:fav_pets] ||= params[:pet_id]
    @favorites ||= Favorite.new(session[:fav_pets])
  end
end
