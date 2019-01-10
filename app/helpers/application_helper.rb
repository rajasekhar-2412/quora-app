module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d, %Y %l:%M%P")
  end
end
