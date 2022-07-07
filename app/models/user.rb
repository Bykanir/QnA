# frozen_string_literal: true

class User < ApplicationRecord
  has_many :answers, class_name: 'Answer', foreign_key: 'author_id'
  has_many :questions, class_name: 'Question', foreign_key: 'author_id'
  has_many :rewards
  has_many :votes
  has_many :comment

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def author_of?(obj)
    id == obj.author_id
  end

  def awarding(reward)
    rewards << reward
  end

  def awarding(reward)
    rewards << reward
  end

  def voted?(voting)
    votes.exists?(votable: voting)
  end
end
