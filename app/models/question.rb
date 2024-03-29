# frozen_string_literal: true

class Question < ApplicationRecord
  include Votable
  include Commentable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_one :reward, dependent: :destroy

  belongs_to :author, class_name: 'User'

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank
  accepts_nested_attributes_for :reward, reject_if: :all_blank

  validates :title, :body, presence: true

  after_create :calculate_reputation
  after_create { subscribe(author) }

  def subscribed?(user)
    subscriptions.exists?(user: user)
  end

  def subscribe(user)
    subscriptions.create(user: user)
  end

  def unsubscribe(user)
    subscriptions.find_by(user: user).destroy
  end

  def subscription(user)
    subscriptions.find_by(user: user)
  end

  private

  def calculate_reputation
    ReputationJob.perform_later(self)
  end
end
