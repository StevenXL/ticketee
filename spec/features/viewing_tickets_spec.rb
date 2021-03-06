require 'rails_helper'

RSpec.feature "User can view tickets" do
  before(:each) do
    author = FactoryGirl.create(:user)

    sublime = FactoryGirl.create(:project, name: "Sublime Text 3")
    FactoryGirl.create(:ticket, project: sublime, name: "Make it Shiny!",
                       description: "Gradients! Starbursts! Oh my!",
                       author: author)

    ie = FactoryGirl.create(:project, name: "Internet Explorer")
    FactoryGirl.create(:ticket, project: ie, name: "Standards Compliance",
                       description: "Isn't a joke.", author: author)

    assign_role!(author, :viewer, sublime)
    assign_role!(author, :viewer, ie)

    login_as(author)

    visit '/'
  end

  scenario "for a given project" do
    click_link "Sublime Text 3"
    expect(page).to have_content "Make it Shiny!"
    expect(page).to_not have_content "Standards Compliance"

    click_link "Make it Shiny"
    within("#ticket h2") do
      expect(page).to have_content "Make it Shiny!"
    end

    expect(page).to have_content "Gradients! Starbursts! Oh my!"
  end
end
