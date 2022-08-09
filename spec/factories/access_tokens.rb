FactoryBot.define do
  factory :access_token, class: 'Doorkeeper::AccessToken' do
    association :application, factory: :oauth_appilication
    resource_owner_id { create(:user).id }
  end
end