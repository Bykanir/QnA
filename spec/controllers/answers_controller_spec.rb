require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }

  describe 'GET #index' do
    it 'render index view' do
      get :index, params: { question_id: question }
      expect(response).to render_template :index
    end  
  end

  describe 'GET #new' do
    it 'render new view' do
      get :new, params: { question_id: question }
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    
  end

end