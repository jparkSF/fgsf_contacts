class ContactBirthday < ActiveRecord::Base
  belongs_to :contact, primary_key: :contact_id, foreign_key: :id
end
