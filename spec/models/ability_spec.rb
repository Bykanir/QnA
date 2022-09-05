# frozen_string_literal: true

require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create(:user, admin: true) }
    let(:other_user) { create(:user, admin: true) }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:question) { create(:question, author: user) }
    let(:other_user_question) { create(:question, author: other_user) }

    let(:answer) { create(:answer, question: question, author: user) }
    let(:other_user_answer) { create(:answer, question: question, author: other_user) }

    let(:comment_question) { create(:comment, commentable: question, author: user) }
    let(:comment_answer) { create(:comment, commentable: answer, author: user) }

    let(:link) { create(:link, linkable: question) }

    let(:attachment) { create(:link, linkable: question) }

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, question }
    it { should_not be_able_to :update, other_user_question }

    it { should be_able_to :update, answer }
    it { should_not be_able_to :update, other_user_answer }

    it { should be_able_to :destroy, question }
    it { should_not be_able_to :destroy, other_user_question }

    it { should be_able_to :destroy, answer }
    it { should_not be_able_to :destroy, other_user_answer }

    it { should be_able_to :best, answer }

    it { should be_able_to %i[voted_for voted_against revote], other_user_question }
    it { should be_able_to %i[voted_for voted_against revote], other_user_answer }

    it { should_not be_able_to %i[voted_for voted_against], question }
    it { should_not be_able_to %i[voted_for voted_against], answer }

    it { should be_able_to :destroy, link }
  end
end
