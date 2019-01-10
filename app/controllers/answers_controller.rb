class AnswersController < QuestionsController
  before_action :find_question
  before_action :find_answer, only: [:destroy, :update]

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

  def update
    @answer.update(answer_attributes)
    respond_with_bip(@answer)
  end

  def destroy
    if @answer.user == current_user && @answer.destroy
      redirect_to @question, notice: "Answer deleted"
    else
      redirect_to @question, error: "We had trouble deleting the answer"
    end
  end

  private

  def find_answer
    @answer = @question.answers.find(params[:id])
  end

  def answer_attributes
    params.require(:answer).permit([:body])
  end
end
