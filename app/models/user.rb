class User
  include Mongoid::Document
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  field :email
  field :encrypted_password
  field :reset_password_token
  field :reset_password_sent_at, type: Time
  field :remember_created_at, type: Time

  has_many :projects
  has_many :missions
  has_many :ideas

  def name
    email.split('@').first
  end
end
