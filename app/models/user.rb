# frozen_string_literal: true
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :timeout_in => 5.minutes

  has_one :user_role, primary_key: :id, foreign_key: :user_id

  def r_admin?
    user_role.try(:admin_r_access?) || user_role.try(:admin_rw_access?) || user_role.try(:admin_rwx_access?)
  end

  def rwx_admin?
    user_role.try(:admin_rwx_access?)
  end
end
