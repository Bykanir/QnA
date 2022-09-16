# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do
  let(:user) { create(:user) }
  let!(:question) { create(:question, author: user) }
  let!(:subscription) { create(:subscription, question: question, user: user) }

  before { login(user) }

  describe 'POST #create' do
    it 'subscribe to question' do
      expect { post :create, params: { question_id: question.id } }.to change(question.subscriptions, :count).by(1)
    end

    it 'redirects to question show' do
      post :create, params: { question_id: question.id }
      expect(response).to redirect_to assigns(:question)
    end
  end

  describe 'DELETE #destroy' do
    it 'user unsubscribes from question' do
      expect do
        delete :destroy, params: { id: subscription.id }
      end.to change(question.subscriptions, :count).by(-1)
    end

    it 'redirects to question show' do
      delete :destroy, params: { id: subscription.id }
      expect(response).to redirect_to question
    end
  end
end
