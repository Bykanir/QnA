require 'rails_helper'

feature 'User can add comment to question' do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:question) { create(:question, author: user) }

  describe 'Authenticated user', js: true do
    scenario 'add new comment to question' do
      sign_in(another_user)
      visit question_path(question)

      within '.comments-question' do
        fill_in 'Comment', with: 'New comment'
        click_on 'Send'

        expect(page).to have_content 'New comment'
      end
    end
  end

  describe 'multiple sessions', js: true do
    scenario "comment appears on another user's pages" do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end

      Capybara.using_session('another_user') do
        sign_in(another_user)
        visit question_path(question)

        within '.comments-question' do
          expect(page).to_not have_content 'New comment'
        end
      end

      Capybara.using_session('user') do
        within '.comments-question' do
          fill_in 'Comment', with: 'New comment'
          click_on 'Send'

          expect(page).to have_content 'New comment'
        end
      end

      Capybara.using_session('another_user') do
        within '.comments-question' do
          expect(page).to have_content 'New comment'
        end
      end
    end
  end
end
