class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @picture = current_user.pictures.build
      
      @pictures = Picture.all.order('created_at DESC').page(params[:page])
      
      
     
      
    end
  end
end
