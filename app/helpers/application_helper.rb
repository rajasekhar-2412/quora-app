module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d, %Y %l:%M%P")
  end

  def author user
  	'Answered by' + user&.first_name.to_s + user&.last_name.to_s
  end
end
