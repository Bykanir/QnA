require 'rails_helper'

feature 'Authenticated user can create answer' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe "Authenticated user", js: true do
    background do
      sign_in(user)
  
      visit question_path(question)
    end

    scenario 'answer the question' do
      fill_in 'Body', with: 'My new answer'
      click_on 'Send'

      expect(current_path).to eq question_path(question)
      within '.answers' do
        expect(page).to have_content 'My new answer'
      end
    end

    scenario 'answer the question with errors' do
      click_on 'Send'
      
      expect(page).to have_content "Body can't be blank"
    end
  end
  
  scenario 'Unauthenticated user tries to answer a question' do
    expect(page).to_not have_button 'Send'
  end

end