module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email',	with: user.email
    fill_in 'Password',	with: user.password 
    click_on 'Log in'
  end

  def add_file(obj)
    obj.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"),
                     filename: 'rails_helper.rb')
  end
end