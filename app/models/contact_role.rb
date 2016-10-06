# frozen_string_literal: true
class ContactRole < ActiveRecord::Base
  ROLES = %w(Leadership Praise Media Welcoming).freeze

  ROLE_NAME_MAPPING = {
    'Leadership' => '리더팀',
    'Praise' => '찬양팀',
    'Media' => '방송팀',
    'Welcoming' => '새가족팀'
  }.freeze

  validates :role_name, inclusion: { in: ROLES, message: '%{value} is not a role.' }

  belongs_to :contact, primary_key: :id, foreign_key: :contact_id

  def self.contact_roles
    hash = {}
    ROLES.each do |role|
      contact_roles = ContactRole.where(role_name: role).order('leader desc')
      hash[role] = contact_roles
    end
    hash
  end

  def self.convert_role(role_name)
    ROLE_NAME_MAPPING[role_name]
  end
end
