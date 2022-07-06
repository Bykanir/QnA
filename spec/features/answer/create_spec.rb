# frozen_string_literal: true

require 'rails_helper'

feature 'Authenticated user can create answer' do
  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
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

    scenario 'asks a question with attached file' do
      fill_in 'Body', with: 'My new answer'

      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb", "#{Rails.root}/spec/spec_helper.rb"]
      click_on 'Send'

      expect(page).to have_link 'rails_helper.rb'
      expect(page).to have_link 'spec_helper.rb'
    end
  end

  scenario 'Unauthenticated user tries to answer a question' do
    expect(page).to_not have_button 'Send'
  end

  describe 'multiple sessions', js: true do
    scenario "answer appears on another user's pages" do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('another_user') do
        sign_in(another_user)
        visit question_path(question)

        within '.answers' do
          expect(page).to_not have_content 'My new answer'
        end
      end

      Capybara.using_session('user') do
        fill_in 'Body', with: 'My new answer'
        click_on 'Send'
        
        expect(page).to have_content 'My new answer'
      end

      Capybara.using_session('another_user') do
        within '.answers' do
          expect(page).to have_content 'My new answer'
        end
      end
    end
  end
end
