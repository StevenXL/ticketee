require 'rails_helper'

RSpec.feature "User can edit existing ticket" do
  let(:author)  { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:ticket)  { FactoryGirl.create(:ticket, project: project, author: author) }

  before(:each) do
    visit project_ticket_path(project, ticket)
    click_link "Edit Ticket"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Make it really shinny!"
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has been updated."

    within("#ticket h2") do
      expect(page).to have_content "Make it really shinny!"
      expect(page).not_to have_content ticket.name
    end
  end

  scenario "with invalid attributes" do
    fill_in "Name", with: ""
    click_button "Update Ticket"

    expect(page).to have_content "Ticket has not been updated."
  end
end
