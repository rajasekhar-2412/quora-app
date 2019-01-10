class QuestionsController < ApplicationController
  before_action :find_question, only: [:edit, :destroy, :update, :vote_up, :vote_down]
  before_action :authenticate_user!, except: [:index]

  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.new(question_attributes)
    if @question.save
      redirect_to questions_path, notice: "Your question was created successfully"
    else
      flash.now[:alert] = "Please correct the form"
      render :new
    end
  end

  def show
    @question = Question.find(params[:question_id] || params[:id])
    @answer = Answer.new
    @favorite = current_user.favorite_for(@question)
    @vote = current_user.vote_for(@question) || Vote.new
    @answers = @question.answers
  end

  def edit
  end

  def update
    if @question.update_attributes(question_attributes)
      redirect_to @question, notice: "Question updated successfully"
    else
      flash.now[:alert] = "Couldn't update"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      redirect_to questions_path, notice: "Question deleted successfully"
    else
      redirect_to question_path, alert: "Delete question failed"
    end
  end

  def vote_up
    @question.increment!(:vote_count)
    session[:has_voted] = true
    redirect_to @question
  end

  def vote_down
  end

  private

  def question_attributes
    params.require(:question).permit([:title, :description, :vote_up, :vote_down, {category_ids: []}])
  end

  def find_question
    @question = Question.find(params[:question_id] || params[:id])
    redirect_to root_path, alert: "Access denied" unless @question
  end

end
