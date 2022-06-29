require 'rails_helper'

feature 'User can voted for answer' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }

  scenario 'Author voted for answer', js: true do
    sign_in(author)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link '-'
    end
  end

  scenario 'Author voted against answer', js: true do
    sign_in(author)
    visit question_path(question)

    within '.answers' do
      expect(page).to_not have_link '-'
    end
  end

  scenario 'User voted for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content 'Rating: 0'

      click_on '+'

      expect(page).to have_content 'Rating: 1'
    end
  end

  scenario 'User voted against answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content 'Rating: 0'

      click_on '-'

      expect(page).to have_content 'Rating: -1'
    end
  end

  scenario 'User twice voted for answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answers' do
      expect(page).to have_content 'Rating: 0'

      click_on '+'
      expect(page).to have_content 'Rating: 1'

      click_on '+'
      expect(page).to have_content 'Rating: 1'
    end

    expect(page).to have_content "You can't voted"
  end
end