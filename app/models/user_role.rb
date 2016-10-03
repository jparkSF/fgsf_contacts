class UserRole < ActiveRecord::Base

  belongs_to :user, primary_key: :user_id, foreign_key: :id

  ROLE_TYPE = %w(admin_rwx_access admin_rw_access admin_r_access).freeze

  ADMIN_RWX_ACCESS = 'admin_rwx_access'.freeze
  ADMIN_R_ACCESS = 'admin_r_access'.freeze


  validates :role_type, inclusion: { in: ROLE_TYPE, message: '%{value} is not a valid role type.' }, allow_nil: true

  def admin_r_access?
    role_type == ADMIN_R_ACCESS
  end

  def admin_rwx_access?
    role_type == ADMIN_RWX_ACCESS
  end



end
