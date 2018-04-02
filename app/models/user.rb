class User < ActiveRecord::Base
  has_secure_password
  has_many :ratings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
    #before_save { self.email = self.email.downcase.strip unless self.email.blank? }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true, length: { minimum: 4 }

  def self.authenticate_with_credentials(email, password)
    email.strip!
    email.downcase!
    if user = User.find_by(email: email).try(:authenticate, password)
      user
    else
      nil
    end
  end

  #
end
