require 'rails_helper'

feature 'User can see all questions' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  
  scenario 'User see all question' do
    visit questions_path

    expect(page).to have_content 'MyString'
  end

end
