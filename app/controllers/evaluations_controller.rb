class EvaluationsController < ApplicationController
  before_action :require_user_logged_in
  def create
    picture = Picture.find(params[:picture_id])
    # rateを使わない場合
    @evaluation = current_user.evaluations.build(evaluation_params)
    @evaluation.picture = picture
    if @evaluation.save
      flash[:success] = 'YOU RATED!'
      redirect_back(fallback_location: root_url)
    else
      redirect_back(fallback_location: root_url)
    end
  end

  def destroy
    picture = Picture.find(params[:picture_id])
    current_user.unrated(picture)
    flash[:success] = 'Bye ratings'
    redirect_back(fallback_location: root_url)
  end
  
  private
    def evaluation_params
      params.require(:evaluation).permit(:point)
    end
  
end
