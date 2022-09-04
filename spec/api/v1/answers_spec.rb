require 'rails_helper'

describe 'Answers API', type: :request do
  let(:headers) { { "CONTENT_TYPE" => "application/json",
                    "ACCEPT" => 'application/json' } }
  let(:resource) { Answer }
  let(:access_token) { create(:access_token) }
  let(:author) { create(:user) }
  let!(:question) { create(:question, author: author)}

  describe 'GET /api/v1/answers' do
    let(:api_path) { api_v1_question_answers_path(question) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let!(:answers) { create_list(:answer, 2, question: question, author: author) }
      let(:answer) { answers.first }
      let(:answer_response) { json['answers'].first }

      before do
        get api_path, params: { access_token: access_token.token }, headers: headers
      end

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns list of questions' do
        expect(json['answers'].size).to eq 2
      end

      it 'returns all public fields' do
        %w[id body created_at updated_at].each do |attr|
          expect(answer_response[attr]).to eq answer.send(attr).as_json
        end
      end

      it 'contains user object' do
        expect(answer_response['author']['id']).to eq answer.author.id
      end
    end
  end

  describe 'GET /api/v1/answers/:id' do
    include ControllerHelpers

    let!(:comments) { create_list(:comment, 3, commentable: answer, user: author) }
    let!(:links) { create_list(:link, 3, linkable: answer) }
    let(:api_path) { api_v1_answer_path(answer) }
    let!(:answer) { create(:answer, question: question, author: author) }
    let(:answer_response) { json['answer'] }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      before do
        add_file(answer)
        get api_path, params: { access_token: access_token.token }, headers: headers
      end

      it 'returns 200 status' do
        expect(response).to be_successful
      end

      it 'returns only one question' do
        expect(json.size).to eq 1
      end

      it_behaves_like 'API Attachments' do
        let(:resource_response) { answer_response }
        let(:obj) { answer }
      end
    end
  end

  describe 'POST /api/v1/answers/' do
    let(:method) { :post }
    let(:api_path) { api_v1_question_answers_path(question) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let(:valid_attrs) { { body: 'Test answer body' } }
      
      it_behaves_like 'API Create' do
        let(:invalid_attrs) { { title: '', body: '' } }
      end
    end
  end

  describe 'PATCH /api/v1/answers/:id' do
    let(:answer) { create(:answer, question: question, author: author) }
    let(:api_path) { api_v1_answer_path(answer) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'authorized' do
      let!(:comment) { create(:comment, commentable: answer, user: answer.author) }
      let(:valid_attrs) { { body: 'Test answer body' } }
      let(:invalid_attrs) { { body: '' } }

      it_behaves_like 'API Update' do
        let(:method) { :patch }
      end
    end
  end
  
  describe 'DELETE /api/v1/answers/:id' do
    let(:answer) { create(:answer, question: question, author: author) }
    let(:api_path) { api_v1_answer_path(answer) }

    it_behaves_like 'API Authorizable' do
      let(:method) { :get }
    end

    context 'when authorized' do
      it_behaves_like 'API Destroy' do
        let(:method) { :delete }
      end
    end
  end
  
end
