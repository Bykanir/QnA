class Question < ApplicationRecord

  has_many :answers, dependent: :destroy

  has_one_attached :file

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, :body, presence: true

end
