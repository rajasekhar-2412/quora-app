class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  validates :body, presence: true

  has_many :comments, dependent: :destroy

  scope :order_by_creation, -> { order("created_at DESC") }
end
