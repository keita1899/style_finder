require "rails_helper"

RSpec.describe "Errors", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe "404 エラーページ" do
    it "ページが見つからない時に404エラーページが表示されること" do
      visit "/non_existent_path"

      expect(page).to have_title("404 | ItemMatch")
      expect(page).to have_content("404")
      expect(page).to have_content("Not Found")
      expect(page).to have_content("指定されたページは存在しません。URLを確認するか、以下から他のページへ移動してください。")
    end
  end
end
