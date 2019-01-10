class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @question = Question.find params[:question_id]
    @favorite = @question.favorites.new
    @favorite.user = current_user
    if current_user
      if @favorite.save
        redirect_to @question, notice: "Thank you for favoriting"
      else
        redirect_to @question, alert: "Unable to save favorite"
      end
    else
      redirect_to new_user_session_path, alert: "Please sign in to favorite"
    end
  end

  def destroy
    @question = Question.find(params[:question_id])
    @favorite = @question.favorites.find(params[:id])
    if @favorite.delete
      redirect_to @question, notice: "You have unfavorited"
    else
      redirect_to @question, alert: "Unable to unfavorite"
    end
  end
end
