# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RewardsController, type: :controller do
  let(:author) { create(:user) }
  let(:question) { create(:question, author: author) }

  describe 'GET #index' do
    let(:rewards) { create_list(:reward, 3, question: question, user: author) }

    before { login(author) }
    before { get :index }

    it 'populates an array of all rewards' do
      expect(assigns(:rewards)).to match_array(rewards)
    end

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end
