require 'rails_helper'

feature 'User can create answer' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  
  scenario 'Answer the question' do
    visit question_path(question)

    fill_in 'Body', with: 'My new answer'
    click_on 'Send'

    expect(page).to have_content 'My new answer'
  end

  # scenario 'Form is empty' do
  #   visit question_path(question)
  #   save_and_open_page

  #   click_on 'Send'

  #   expect(page).to have_content "Body can't be blank"
  # end

end