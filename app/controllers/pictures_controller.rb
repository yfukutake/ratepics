class PicturesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    random_ids=Picture.pluck(:id).sample(6)
    @picture = current_user.pictures.build
    @pictures = Picture.all.find(random_ids)
  end
  
  def create
    @picture = current_user.pictures.build(picture_params)
    if @picture.save
      flash[:success] = '投稿しました'
      redirect_back(fallback_location: root_url)
    else
      #レンダー先の一覧表示用
      @pictures = current_user.pictures.order('created_at DESC').page(params[:page])
      flash.now[:danger] = '投稿できません'
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    @picture.destroy
    flash[:success] = '削除しました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def picture_params
    params.require(:picture).permit(:image, :image_cache)
  end
  
  def correct_user
    @picture = current_user.pictures.find_by(id: params[:id])
    unless @picture
      redirect_to root_url
    end
  end
end
