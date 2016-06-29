class User < ActiveRecord::Base
  before_save {self.email = email.downcase if email.present?}
  # Validate name
  validates :name, length: {minimum: 1, maximum: 100}, presence: true
  # Validate password
  validates :password, presence: true, length:{minimum: 6}, unless: :password_digest
  validates :password, length: {minimum: 6}, allow_blank: true
  # Validate email
  validates :email,
            presence: true,
            uniqueness: {case_sensitive: false},
            length: {minimum: 3, maximum: 254}

    has_secure_password
end