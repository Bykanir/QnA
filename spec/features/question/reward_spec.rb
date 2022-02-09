# frozen_string_literal: true

require 'rails_helper'

feature 'User can get reward for the best answer' do

  given!(:author) { create(:user) }

  scenario 'User get reward', js: true do
    sign_in(author)
    visit new_question_path

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text text'
    within '.reward' do
      fill_in 'Reward title', with: 'Reward for test question'
      attach_file 'Image', "#{Rails.root}/app/assets/images/reward.png"
    end
    click_on 'Ask'

    fill_in 'Body', with: 'Answer'
    click_on 'Send'
    click_on 'Best answer'

    click_on 'Your rewards'

    expect(page).to have_content 'Reward for test question'
    expect(page).to have_content 'Test question'
  end
end
