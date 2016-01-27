class User < ActiveRecord::Base
  has_many :posts
  validates :username, presence: true
  validates :username, uniqueness: true
  validates :email, presence: true
  validates :email, uniqueness: true
  validates :password, presence: true
  before_validation :strip_email

  validates :email, format:
  { with:
    /\A(([A-Za-z0-9]*\.+*_+)|([A-Za-z0-9]+\-+)|
    ([A-Za-z0-9]+\+)|([A-Za-z0-9]+\+))*[A-Z‌​a-z0-9]+@{1}((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,4}\z/,
    message: "invalid email"
  }

  private

  def strip_email
    self.email = email.strip unless email.nil?
  end
end
