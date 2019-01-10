class AnswersController < QuestionsController
  before_action :find_question

  def create
    @answer = @question.answers.new(answer_attributes)
    @answer.user = current_user
    respond_to do |format|
      if @answer.save
        format.js { render "create" }
      else
        # format.html { render "questions/show" }
        format.js { render js: "alert('answer can not be empty');" and return }
        # render "/questions/show"
      end
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.user == current_user && @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, error: "We had trouble deleting the answer"
    end
  end

  private

  def answer_attributes
    params.require(:answer).permit([:body])
  end
end
