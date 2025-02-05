class EmailsController < ApplicationController
  def index
    @emails = Email.includes(:email_history).order(created_at: :desc)
  end

  def new
    @email = Email.new
  end

  def create
    @email = Email.new(email_params)

    if @email.save
      @email.generate_content
      redirect_to @email, notice: 'Email was successfully generated.'
    else
      render :new
    end
  end

  def show
    @email = Email.find(params[:id])
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