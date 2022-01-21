require 'rails_helper'

feature 'User can edit question', %q{
  In order to correct mistakes
  As an authir of question
  I'd like to be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }

  describe 'Authenticated user' do
    background do
      sign_in(author)
      visit question_path(question)

      click_on 'Edit question'
    end

    scenario 'edits his question', js: true do
      within '.question' do
        fill_in 'Your question', with: 'Edited question'
        click_on 'Save'
  
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his question with errors', js: true do
      within '.question' do
        fill_in 'Your question',	with: ''
        click_on 'Save'

        expect(page).to have_content "Body can't be blank"
       end
    end
  end

  scenario 'Unauthenticated user can not edit question', js: true do
    visit question_path(question)
    
    expect(page).to_not have_link 'Edit answer'
  end
  
  scenario "tries to edit other user's question", js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_button 'Edit answer'
  end
  
end