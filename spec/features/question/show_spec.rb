require 'rails_helper'

feature 'User can view question and answers to it' do

  given(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  
  scenario 'User can view question' do
    visit questions_path
    
    click_on 'MyString'

    expect(page).to have_content 'MyString'
    expect(page).to have_content 'MyText'
  end

  scenario 'User can view answers to question' do
    sign_in(user)
    
    Answer.create(body: 'MyAnswer', question: question, author: user)
    visit question_path(question)

    expect(page).to have_content 'MyAnswer'
  end

  scenario 'For question no answers' do
    visit question_path(question)

    expect(page).to have_content 'No answers yet'
  end

end
