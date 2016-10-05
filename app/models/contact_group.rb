# frozen_string_literal: true
class ContactGroup < ActiveRecord::Base
  has_many :contacts, primary_key: :contact_id, foreign_key: :id

  GROUP_NAMES = %w(1 2 3 4 5 6 7).freeze
  KM = 'KM'
  GROUP_TYPES = [KM].freeze

  validates :group_name, inclusion: { in: GROUP_NAMES, message: '%{value} is not a group.' }, allow_nil: true
  validates :group_type, inclusion: { in: GROUP_TYPES, message: '%{value} is not a type.' }, allow_nil: true

  def contacts
    contact_ids = ContactGroup.where(group_name: group_name).pluck(:contact_id)
    Contact.where(id: contact_ids)
  end

  # returns:
  # {
  #   '1' => [<Contact #id: 1, name: '김보라', ...>, <Contact...>],
  #   '2' => [<Contact #id: 5, name: '김..', ...>, <Contact...>],
  #   ...
  # }
  def self.contact_groups(type)
    hash = {}
    GROUP_NAMES.each do |group_name|
      contact_ids = ContactGroup.where(group_type: type, group_name: group_name).pluck(:contact_id)
      contacts = Contact.where(id: contact_ids)
      hash[group_name] = contacts
    end
    hash
  end
end
