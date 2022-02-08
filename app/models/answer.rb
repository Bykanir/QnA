class Answer < ApplicationRecord

  has_many :links, dependent: :destroy, as: :linkable

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :question

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank

  validates :body, presence: true

  scope :sort_by_best, -> { order(best: :desc) }

  def mark_as_best
    transaction do
      question.answers.update_all(best: false)
      self.author.awarding(question.reward) if question.reward.present?
      update(best: true)
    end
  end
  
end
