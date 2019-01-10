class Answer < ActiveRecord::Base
  belongs_to :question
  validates_presence_of :body

  has_many :comments, dependent: :destroy

  scope :order_by_creation, -> { order("created_at DESC") }
end
