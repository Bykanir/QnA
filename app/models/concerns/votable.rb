# frozen_string_literal: true

module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, dependent: :destroy, as: :votable
  end

  def vote_up(user)
    vote(user, 1)
  end

  def vote_dawn(user)
    vote(user, -1)
  end

  def all_votes
    votes.sum(:score)
  end

  def delete_vote(user)
    votes.find_by(user_id: user).destroy
  end

  private

  def vote(user, score)
    votes.create!(user: user, score: score)
  end
end
