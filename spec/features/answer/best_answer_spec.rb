require 'rails_helper'

feature 'Author can choice best answer' do

  given!(:author) { create(:user) }
  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: author) }
  given!(:answer_1) { create(:answer, question: question, author: author) }
  given!(:answer_2) { create(:answer, question: question, author: user) }
  given(:reward) { create(:reward, question: question, image: image) }
  
  scenario 'Author choice only 1 best answer', js: true do
    sign_in(author) 

    visit question_path(question)

    within("#answer-#{answer_1.id}") do
      click_on 'Best answer'

      expect(page).to_not have_button 'Best answer'
    end
  end

  scenario 'Best answer display first in list', js: true do
    sign_in(author)

    visit question_path(question)
    
    within("#answer-#{answer_2.id}") do
      click_on 'Best answer'

      expect(answer_2).to eq question.answers.sort_by_best.first
    end
  end

  scenario 'Author choice another best answer', js: true do
    sign_in(author) 

    visit question_path(question)

    within("#answer-#{answer_1.id}") do
      click_on 'Best answer'

      expect(page).to_not have_button 'Best answer'
    end

    within("#answer-#{answer_2.id}") do
      click_on 'Best answer'

      expect(page).to_not have_button 'Best answer'
    end
  end

  scenario "Another user can't choice best answer", js: true do
    sign_in(user)

    visit question_path(question)

    expect(page).to_not have_button 'Best answer'
  end

end