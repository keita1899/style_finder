class RecognitionsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recognition = current_user.recognitions.new
  end

  def create
    @recognition = current_user.recognitions.new(recognition_params)

    if @recognition.save
      redirect_to new_recognition_path, notice: "画像をアップロードしました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def recognition_params
      params.require(:recognition).permit(:image)
    end
end
