class User < ActiveRecord::Base
  has_many :tag_groups, :dependent => :destroy
  attr_accessible :username, :email, :password, :password_confirmation
  has_secure_password

  before_save { |user| user.email = email.downcase }

  validates :username, presence: true, length: { maximum: 50 },
            uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
                    format:     { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  
  before_save :create_remember_token

  def to_param
		username
	end

  private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

end



