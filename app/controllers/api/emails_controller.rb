class Api::EmailsController < ApplicationController
  def create
    email = Email.new(email_params)

    if email.save
      email.generate_content
      render json: email, status: :created
    else
      render json: { errors: email.errors }, status: :unprocessable_entity
    end
  end

  private

  def email_params
    params.require(:email).permit(
      :purpose,
      :recipient_info,
      :sender_info,
      parameters: [:reading_time, :language, :tone]
    )
  end
end