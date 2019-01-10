module ApplicationHelper
  def formatted_date date
    date.strftime("%b %d, %Y %l:%M%P")
  end

  def author user
  	'Answered by' + user&.full_name.to_s
  end

  def display_name user
  	'Hello!! ' + user.full_name.to_s
  end
end
