require 'rails_helper'

RSpec.feature "Signed-in user can sign out" do
  let!(:user) { FactoryGirl.create(:user) }

  before(:each) do
    login_as(user)
  end

  scenario do
    visit "/"
    click_link "Sign out"
    expect(page).to have_content "Signed out successfully."
  end
end
