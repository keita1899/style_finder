require "rails_helper"

RSpec.describe "Home", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "GET #index" do
    it "ホームページが正しく表示されること" do
      visit root_path
      expect(page).to have_title("Home | ItemMatch")
      expect(page).to have_current_path(root_path)
    end
  end
end
