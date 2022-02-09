# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { create(:question, author: author) }
  let!(:answer) { create(:answer, question: question, author: author) }
  let!(:question_link) { create(:link, linkable: question) }
  let!(:answer_link) { create(:link, linkable: answer) }

  describe 'DELETE #destroy' do
    context 'User author' do
      before { login(author) }

      it 'delete link in question' do
        expect { delete :destroy, params: { id: question_link }, format: :js }.to change(Link, :count).by(-1)
      end

      it 'delete link in answer' do
        expect { delete :destroy, params: { id: answer_link }, format: :js }.to change(Link, :count).by(-1)
      end

      it 'render destroy' do
        delete :destroy, params: { id: answer_link }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'User not author' do
      before { login(user) }

      it 'delete link in question' do
        expect { delete :destroy, params: { id: question_link }, format: :js }.to_not change(Link, :count)
      end

      it 'delete link in answer' do
        expect { delete :destroy, params: { id: answer_link }, format: :js }.to_not change(Link, :count)
      end
    end
  end
end
