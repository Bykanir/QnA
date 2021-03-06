# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let(:question) { create(:question, author: author) }
  let!(:answer) { create(:answer, question: question, author: author) }
  let!(:reward) { create(:reward, question: question) }

  describe 'POST #create' do
    before { login(author) }

    context 'with valid attributes' do
      it 'saves a new answer in the database' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer, author: author) },
                        format: :js
        end.to change(question.answers, :count).by(1)
      end

      it 'renders create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer), format: :js }
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect do
          post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) },
                        format: :js
        end.to_not change(Answer, :count)
      end

      it 'renders create template' do
        post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid), format: :js }
        expect(response).to render_template :create
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'User author of the answer' do
      before { login(author) }

      it 'delete the answer' do
        expect do
          delete :destroy, params: { question_id: question, id: answer }, format: :js
        end.to change(Answer, :count).by(-1)
      end

      it 'redirects to show' do
        delete :destroy, params: { question_id: question, id: answer }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'User not author of the answer' do
      before { login(user) }

      it 'delete the answer' do
        expect do
          delete :destroy, params: { question_id: question, id: answer }, format: :js
        end.to_not change(Answer, :count)
      end
    end
  end

  describe 'PATCH #update' do
    before { login(author) }

    context 'with valid attributes' do
      it 'changes answer attributes' do
        patch :update, params: { question_id: question, id: answer, answer: { body: 'new body' } }, format: :js
        answer.reload
        expect(answer.body).to eq 'new body'
      end

      it 'renders update view' do
        patch :update, params: { question_id: question, id: answer, answer: { body: 'new body' } }, format: :js
        expect(response).to render_template :update
      end
    end

    context 'with invalid attributes' do
      it 'does not change answer attributes' do
        expect do
          patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer, :invalid) },
                         format: :js
        end.to_not change(answer, :body)
      end

      it 'renders update view' do
        patch :update, params: { question_id: question, id: answer, answer: attributes_for(:answer, :invalid) },
                       format: :js
        expect(response).to render_template :update
      end
    end
  end

  describe 'PATCH #best' do
    before { login(author) }

    it 'author mark answer best' do
      patch :best, params: { question_id: question, id: answer, format: :js }
      answer.reload
      expect(answer).to be_best
    end

    it 'renders best view' do
      patch :best, params: { question_id: question, id: answer, format: :js }
      expect(response).to render_template :best
    end
  end
end
