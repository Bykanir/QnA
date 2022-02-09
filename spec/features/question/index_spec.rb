# frozen_string_literal: true

require 'rails_helper'

feature 'User can see all questions' do
  given(:user) { create(:user) }
  given!(:questions) { create_list(:question, 2, author: user) }

  scenario 'User see all question' do
    visit questions_path

    questions.each { |question| expect(page).to have_content question.title.to_s }
  end
end
