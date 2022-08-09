FactoryBot.define do
  factory :oauth_appilication, class: 'Doorkeeper::Application' do
    name { 'Test' }
    redirect_uri { 'urn:ietf:wg:oauth:2.0:oob' }
    uid { '12345678' }
    secret { '24857924759' }
  end
end