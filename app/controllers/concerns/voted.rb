module Voted 
  extend ActiveSupport::Concern

  included do
    before_action :set_votable, only: [:voted_for, :voted_against, :revote]
  end

  def voted_for
    if current_user.voted?(@votable)
      render_error
    else
      @votable.vote_up(current_user)
      render_voting
    end 
  end

  def voted_against
    if current_user.voted?(@votable)
      render_error
    else
      @votable.vote_dawn(current_user)
      render_voting
    end 
  end

  def revote
    @votable.delete_vote(current_user)
    render_voting
  end

  private 

  def model_klass
    controller_name.classify.constantize
  end

  def set_votable
    @votable = model_klass.find(params[:id])
  end

  def render_voting
    render json: { score: @votable.all_votes, type: @votable.class.to_s, id: @votable.id }
  end

  def render_error
    render json: { error: "You can't voted" }, status: :unprocessable_entity
  end
end