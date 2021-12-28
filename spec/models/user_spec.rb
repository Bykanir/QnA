require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:answers).class_name('Answer').with_foreign_key('author_id') }
  it { should have_many(:questions).class_name('Question').with_foreign_key('author_id') }

  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
end
