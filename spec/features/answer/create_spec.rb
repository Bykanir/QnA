require 'rails_helper'

feature 'Authenticated user can create answer' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  describe "Authenticated user" do
    background do
      sign_in(user)
  
      visit question_path(question)
    end

    scenario 'answer the question' do
      fill_in 'Body', with: 'My new answer'
      click_on 'Send'
  
      expect(page).to have_content 'My new answer'
    end

    # scenario 'answer the question with errors' do
    #   visit question_path(question)
    #   save_and_open_page

    #   click_on 'Send'

    #   expect(page).to have_content "Body can't be blank"
    # end
  end
  
  scenario 'Unauthenticated user tries to answer a question' do
    visit question_path(question)
    
    fill_in 'Body', with: 'My new answer'
    click_on 'Send'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

end