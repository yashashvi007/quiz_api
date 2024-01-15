class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include Devise::JWT::RevocationStrategies::JTIMatcher
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self


  has_many :user_assesments
  has_many :assesments, through: :user_assesments

  before_create :set_default_role

  enum :role, [:super_admin , :admin , :student]

  def jwt_payload
   super
  end

  def jwt_token
    JWT.encode(jwt_payload, Rails.application.credentials.secret_key_base)
  end


  def set_default_role
    self.role ||= :student
  end

end
