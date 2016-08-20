class Member < ApplicationRecord

  validates :full_name, {
    presence: true,
    uniqueness: { if: :full_name_changed?, message: :already_registered },
  }

  validates :email, {
    presence: true,
    uniqueness: { if: :email_changed?, message: :already_registered },
    format: /.+@.+\..+/
  }

  validates :address, presence: true

  before_create :set_joined_at
  after_create :reset_token!

  def reset_token!
    update! token: SecureRandom.hex, token_updated_at: Time.current
  end

private

  def set_joined_at
    self.joined_at ||= Time.current
  end

end
