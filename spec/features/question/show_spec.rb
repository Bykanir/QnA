# frozen_string_literal: true

require 'rails_helper'

feature 'User can view question and answers to it' do
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  background { sign_in(user) }

  describe 'Questions' do
    scenario 'User can view question' do
      visit questions_path

      click_on 'MyString'

      expect(page).to have_content 'MyString'
      expect(page).to have_content 'MyText'
    end
  end

  describe 'Answers' do
    given!(:answers) { create_list(:answer, 2, question: question, author: user) }

    scenario 'User can view answers to question' do
      visit question_path(question)

      answers.each { |answer| expect(page).to have_content answer.body.to_s }
    end
  end

  scenario 'For question no answers' do
    visit question_path(question)

    expect(page).to have_content 'No answers yet'
  end
end
