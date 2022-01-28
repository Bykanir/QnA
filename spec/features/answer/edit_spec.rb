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
  
  describe 'Authenticated user', js: true do
    background do
      sign_in(author)
      add_file(answer)
      visit question_path(question)

      click_on 'Edit answer'
    end

    scenario 'edits his answer' do
      within '.answers' do
        fill_in 'Your answer',	with: 'Edited answer'
        click_on 'Save'
        
        expect(page).to_not have_content answer.body
        expect(page).to have_content 'Edited answer'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his answer with errors' do
      within '.answers' do
        fill_in 'Your answer',	with: ''
        click_on 'Save'

        expect(page).to have_content "Body can't be blank"
       end
    end

    scenario 'edits answer with attached file' do
      within '.answers' do
        fill_in 'Your answer',	with: 'Edited answer'

        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'
  
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
       end
    end

    scenario 'delete attached answer file' do
      within '.answers' do
        fill_in 'Your answer',	with: 'Edited question'
        expect(page).to have_link 'rails_helper.rb'

        click_on 'Delete file'

        expect(page).to_not have_link 'rails_helper.rb'
      end

      expect(page).to have_content 'File deleted'
    end
  end

  scenario "tries to edit other user's question", js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_button 'Edit answer'
  end
  
end