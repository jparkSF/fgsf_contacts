class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contacts
  has_one :user_role, primary_key: :id, foreign_key: :user_id


  def r_admin?
    if user_role == nil
      false
    else
      user_role.admin_r_access?
    end
  end

  def rwx_admin?
    if user_role == nil
      false
    else
      user_role.admin_rwx_access?
    end
  end
end
