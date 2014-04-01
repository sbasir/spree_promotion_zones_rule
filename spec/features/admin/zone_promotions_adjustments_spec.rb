require 'spec_helper'

describe "Promotion Adjustments" do
  stub_authorization!

  context "promotions", :js => true do
    before(:each) do
      visit spree.admin_path
      click_link "Promotions"
      click_link "New Promotion"
    end

    it "should allow an admin to create a zone promo" do
      create(:zone, :name => "Asia")

      fill_in "Name", :with => "Promotion"
      click_button "Create"
      page.should have_content("Editing Promotion")

      select "Zone(s)", :from => "Add rule of type"

    end
  end
end