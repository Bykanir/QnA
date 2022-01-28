require 'rails_helper'

RSpec.describe AttachmentsController, type: :controller do
  let(:author) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { create(:question, author: author) }
  let!(:answer) { create(:answer, question: question, author: author) }

  describe 'DELETE #destroy' do
    before { add_file(question) }
    before { add_file(answer) }

    context 'User author' do
      before { login(author) }

      it 'delete file in question' do
        expect { delete :destroy, params: { id: question.files.first },
                        format: :js }.to change(question.files, :count).by(-1)
      end

      it 'delete file in answer' do
        expect { delete :destroy, params: { id: answer.files.first },
                        format: :js }.to change(answer.files, :count).by(-1)
      end

      it 'render destroy' do
        delete :destroy, params: { id: answer.files.first }, format: :js
        expect(response).to render_template :destroy
      end
    end

    context 'User not author' do
      before { login(user) }

      it 'delete file in question' do
        expect { delete :destroy, params: { id: question.files.first },
                        format: :js }.to_not change(question.files, :count)
      end

      it 'delete file in answer' do
        expect { delete :destroy, params: { id: answer.files.first },
                        format: :js }.to_not change(answer.files, :count)
      end
    end
  end

end