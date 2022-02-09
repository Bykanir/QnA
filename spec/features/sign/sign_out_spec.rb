# frozen_string_literal: true

require 'rails_helper'

feature 'User can log out' do
  given(:user) { create(:user) }

  scenario 'Authenticated user tries to sign out' do
    sign_in(user)

    click_on 'Logout'

    expect(page).to have_content 'Signed out successfully.'
  end
end
