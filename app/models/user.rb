class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  validates_presence_of :name, :date_of_birth
  validates :email, presence: true, uniqueness: true,
                    format: { with: URI::MailTo::EMAIL_REGEXP },
                    case_sensitive: false

  def birthday?
    date_of_birth == Date.today
  end

  def send_registration_email
    UserMailer.registration(self).deliver_later

    self.confirmation_sent_at = Time.now
    save!
  end
end
