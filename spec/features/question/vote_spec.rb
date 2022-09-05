# frozen_string_literal: true

require 'rails_helper'

feature 'User can voted for question' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, author: author) }

  scenario 'Author voted for question', js: true do
    sign_in(author)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link '+'
    end
  end

  scenario 'Author voted against question', js: true do
    sign_in(author)
    visit question_path(question)

    within '.question' do
      expect(page).to_not have_link '-'
    end
  end

  scenario 'User voted for question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to have_content 'Rating: 0'

      click_on '+'

      expect(page).to have_content 'Rating: 1'
    end
  end

  scenario 'User voted against question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to have_content 'Rating: 0'

      click_on '-'

      expect(page).to have_content 'Rating: -1'
    end
  end

  scenario 'User twice voted for question', js: true do
    sign_in(user)
    visit question_path(question)

    within '.question' do
      expect(page).to have_content 'Rating: 0'

      click_on '+'
      expect(page).to have_content 'Rating: 1'

      click_on '+'
      expect(page).to have_content 'Rating: 1'
    end

    expect(page).to have_content "You can't voted"
  end
end
