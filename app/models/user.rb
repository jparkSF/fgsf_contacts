class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :contacts
  has_one :user_role, primary_key: :id, foreign_key: :user_id


  def is_admin?
    user_role.role_type.present?
    puts "is_admin?"
  end

  def rwx_admin?
    user_role.role_type.present? && user_role.admin_rwx_access?
  end




end
