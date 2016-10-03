class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contacts
  has_one :user_role, primary_key: :id, foreign_key: :user_id, dependent: destroy

  def user_is_admin?
   user_role.present?
  end

  def rwx_admin?
   user_role.present? && user_role.rwx_admin?
  end
end
