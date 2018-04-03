require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js: true do

  # SETUP
  before :each do
    @user = User.create!(
        first_name:  'Lorena',
        last_name: 'Reyes',
        email: 'lorena@gmail.com',
        password: 'test',
        password_confirmation: 'test'
      )

end

scenario "User can login and go to home page" do

    visit root_path
    click_link 'Login'

    fill_in :email, :with => 'lorena@gmail.com'
    fill_in :password, :with => 'test'

    click_button 'Submit'


    # DEBUG / VERIFY
    save_screenshot 'jungle2.png'

    expect(page).to have_content 'Signed in as Lorena'
   end
end