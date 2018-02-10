class ToppagesController < ApplicationController
  def index
    if logged_in?
      @user = current_user
      @picture = current_user.pictures.build
      
      #これは自分の投稿の一覧なので要修正
      @pictures = current_user.pictures.order('created_at DESC').page(params[:page])
    end
  end
end
