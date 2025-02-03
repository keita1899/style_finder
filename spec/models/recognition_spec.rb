require "rails_helper"

RSpec.describe Recognition, type: :model do
  describe "バリデーション" do
    let(:image_png) { fixture_file_upload("sample.png") }
    let(:image_jpeg) { fixture_file_upload("sample.jpeg") }
    let(:image_gif) { fixture_file_upload("sample.gif", "image/gif") }
    let(:image_1mb) { fixture_file_upload("1MB_sample.png") }
    let(:image_3mb) { fixture_file_upload("3MB_sample.png") }
    let(:image_5mb) { fixture_file_upload("5MB_sample.png") }
    let(:invalid_image) { fixture_file_upload("sample.txt", "text/plain") }

    let(:recognition) { build(:recognition) }

    context "有効な場合" do
      it "画像の拡張子がPNGの場合、バリデーションが成功する" do
        recognition.image = image_png
        expect(recognition).to be_valid
      end

      it "画像の拡張子がJPEGの場合、バリデーションが成功する" do
        recognition.image = image_jpeg
        expect(recognition).to be_valid
      end

      it "画像のサイズが3MB未満の場合、バリデーションが成功する" do
        recognition.image = image_1mb
        expect(recognition).to be_valid
      end
    end

    context "無効な場合" do
      it "画像が添付されていない場合、バリデーションが失敗する" do
        recognition.image = nil
        expect(recognition).to be_invalid
      end

      it "画像の拡張子がGIFの場合、バリデーションが失敗する" do
        recognition.image = image_gif
        expect(recognition).to be_invalid
      end

      it "画像の拡張子が無効な場合（例: text/plain）、バリデーションが失敗する" do
        recognition.image = invalid_image
        expect(recognition).to be_invalid
      end

      it "画像のサイズが3MBの場合、バリデーションが失敗する" do
        recognition.image = image_3mb
        expect(recognition).to be_invalid
      end

      it "画像のサイズが3MB以上の場合、バリデーションが失敗する" do
        recognition.image = image_5mb
        expect(recognition).to be_invalid
      end
    end
  end
end
