# frozen_string_literal: true

require 'rails_helper'

feature 'Subscribes to question' do
  given(:author) { create(:user) }
  given(:user) { create(:user) }
  given(:question) { create(:question, author: author) }

  describe 'other user' do
    before do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'User can subscribe to question' do
      click_on 'Subscribe'

      expect(page).to have_content 'You subscribed'
      expect(page).to_not have_link 'Subscribe'
      expect(page).to have_link 'Unsubscribe'
    end

    scenario 'User can unsubscribe from question' do
      click_on 'Subscribe'
      click_on 'Unsubscribe'

      expect(page).to have_content 'You unsubscribed'
      expect(page).to_not have_link 'Unubscribe'
      expect(page).to have_link 'Subscribe'
    end
  end

  describe 'author' do
    before do
      sign_in(author)
      visit question_path(question)
    end

    scenario 'Author can unsubscribe to his question' do
      click_on 'Unsubscribe'

      expect(page).to have_content 'You unsubscribed'
      expect(page).to_not have_link 'Unubscribe'
      expect(page).to have_link 'Subscribe'
    end
  end
end
