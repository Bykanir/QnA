# frozen_string_literal: true

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  skip_authorization_check

  def create
    question.subscribe(current_user)
    redirect_to question_path(question), notice: 'You subscribed'
  end

  def destroy
    subscription.question.unsubscribe(subscription.user)
    redirect_to question_path(subscription.question), notice: 'You unsubscribed'
  end

  private

  def question
    @question ||= Question.find(params[:question_id])
  end

  def subscription
    @subscription ||= Subscription.find(params[:id])
  end
end
