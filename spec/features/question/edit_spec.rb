require 'rails_helper'

feature 'User can edit question', %q{
  In order to correct mistakes
  As an authir of question
  I'd like to be able to edit my question
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question) { create(:question, author: author) }

  describe 'Authenticated user', js: true do
    background do
      sign_in(author)
      add_file(question)
      visit question_path(question)

      click_on 'Edit question'
    end

    scenario 'edits his question' do
      within '.question' do
        fill_in 'Your question', with: 'Edited question'
        click_on 'Save'
  
        expect(page).to_not have_content question.body
        expect(page).to have_content 'Edited question'
        expect(page).to_not have_selector 'textarea'
      end
    end

    scenario 'edits his question with errors' do
      within '.question' do
        fill_in 'Your question',	with: ''
        click_on 'Save'

        expect(page).to have_content "Body can't be blank"
       end
    end

    scenario 'edits a question with attached file' do
      within '.question' do
        fill_in 'Your question',	with: 'Edited question'

        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
        click_on 'Save'
  
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
       end
    end

    scenario 'delete attached question file' do
      within '.question' do
        fill_in 'Your question',	with: 'Edited question'
        expect(page).to have_link 'rails_helper.rb'

        click_on 'Delete file'

        expect(page).to_not have_link 'rails_helper.rb'
      end

      expect(page).to have_content 'File deleted'
    end
  end

  scenario 'Unauthenticated user can not edit question', js: true do
    visit question_path(question)
    
    expect(page).to_not have_link 'Edit answer'
  end
  
  scenario "tries to edit other user's question", js: true do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_button 'Edit answer'
  end
  
end