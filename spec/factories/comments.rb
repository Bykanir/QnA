FactoryBot.define do
  factory :comment do
    body { 'body' }
    user { nil }
    commentable { nil }
  end
end