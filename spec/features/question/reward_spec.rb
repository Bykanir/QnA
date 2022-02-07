# require 'rails_helper'
#
# feature 'User can get reward for the best answer' do
#
#   given!(:author) { create(:user) }
#   given!(:user) { create(:user) }
#   given!(:question) { create(:question, author: author) }
#   given!(:reward) { create(:reward, question: question) }
#   given!(:answer) { create(:answer, question: question, author: user) }
#
#   scenario 'User get reward' do
#     using_session('author') do
#       sign_in(author)
#       visit questions_path(question)
#
#       click_on 'Best answer'
#     end
#
#     using_session('user') do
#       sign_in(user)
#       visit rewards_path
#
#       expect(page).to have_content 'Reward for test question'
#       # expect(page).to have_image 'reward.png'
#     end
#   end
# end