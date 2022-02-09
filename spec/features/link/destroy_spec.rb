# frozen_string_literal: true

require 'rails_helper'

feature 'User can delete link for question or answer' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }
  given!(:question_link) { create(:link, linkable: question) }
  given!(:answer_link) { create(:link, linkable: answer) }

  describe 'Author', js: true do
    background do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'delete link question' do
      within '.question' do
        expect(page).to have_link 'Google'
        click_on 'Delete link'
        expect(page).to_not have_link 'Google'
      end
      expect(page).to have_content 'Your link successfully deleted.'
    end

    scenario 'delete link answer' do
      within '.answers' do
        expect(page).to have_link 'Google'
        click_on 'Delete link'
        expect(page).to_not have_link 'Google'
      end
      expect(page).to have_content 'Your link successfully deleted.'
    end
  end

  describe 'Any user', js: true do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'tries delete link question' do
      within '.question' do
        expect(page).to_not have_link 'Delete link'
      end
    end

    scenario 'tries delete link answer' do
      within '.answers' do
        expect(page).to_not have_link 'Delete link'
      end
    end
  end

  describe 'Unauthenticated user', js: true do
    background do
      visit question_path(question)
    end

    scenario 'tries delete link question' do
      within '.question' do
        expect(page).to_not have_link 'Delete link'
      end
    end

    scenario 'tries delete link answer' do
      within '.answers' do
        expect(page).to_not have_link 'Delete link'
      end
    end
  end
end
