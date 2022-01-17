require 'rails_helper'

feature 'User can edit answer', %q{
  In order to correct mistakes
  As an authir of answer
  I'd like to be able to edit my answer
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }

  scenario 'Unauthenticated user can not edit answer' do
    visit question_path(question)
    
    expect(page).to_not have_link 'Edit answer'
  end
  
  describe 'Authenticated user' do
    scenario 'edits his answer', js: true do
      sign_in author
      visit question_path(question)

      click_on 'Edit answer'

      within '.answers' do
        fill_in 'Your answer',	with: 'Edited answer'
        click_on 'Save'
        
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors'
    scenario "tries to edit other user's question"
  end
end