require 'rails_helper'

feature 'User can delete their question' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }
  
  scenario 'Author delete their question' do
    sign_in(author)

    visit question_path(question)
    click_on 'Delete question'

    expect(page).to have_content 'Your question successfully deleted.'
  end

  scenario 'Any user delete question' do
    sign_in(user)

    visit question_path(question)

    expect(page).to_not have_content 'Delete question'
  end

end