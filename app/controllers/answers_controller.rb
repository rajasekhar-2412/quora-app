class AnswersController < QuestionsController
  before_action :find_question

  def create
    @answer = @question.answers.new(answer_attributes)
    @answer.user_id = current_user
    respond_to do |format|
      if @answer.save
        # AnswerMailer.delay.notify_question_owner(@answer)
        # format.html { redirect_to @question, notice: "Answer created successfully" }
        format.js { render "create" }
      else
        format.html { render "questions/show" }
        format.json { render js: "alert('ERROR');" }
        render "/questions/show"
      end
    end
  end

  def destroy
    @answer = @question.answers.find(params[:id])
    if @answer.user = current_user && @answer.destroy
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
