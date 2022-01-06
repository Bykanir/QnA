require 'rails_helper'

feature 'User can delete their question' do

  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer) { create(:answer, question: question, author: author) }

  scenario 'Author delete their answer' do
    sign_in(author)

    visit question_path(question)
    
    expect(page).to have_content 'MyAnswer'

    click_on 'Delete answer'

    expect(page).to have_content 'Your answer successfully deleted.'
    expect(page).to_not have_content 'MyAnswer'
  end

  scenario 'Any user delete answer' do
    sign_in(user)

    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end

  scenario 'Unauthenticated user delete answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Delete answer'
  end

end