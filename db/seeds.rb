require 'csv'

def create_role(contact, role, leader)
  obj = ContactRole.find_or_create_by!(contact_id: contact.id, role_name: role)
  obj.update_attributes!(leader: leader)
end

csv_text = File.read('db/feed.csv')
csv = CSV.parse(csv_text, :headers => true)
csv.each do |row|
  # {"group_name"=>"4", "name"=>"김용현", "gender"=>"male"}
  hash = row.to_hash
  contact = Contact.find_or_create_by!(name: hash['name'], gender: hash['gender'])
  birthday = ContactBirthday.find_or_create_by!(contact_id: contact.id)
  birthday.update_attributes!(year: hash['year'].to_i)
  group = ContactGroup.find_or_create_by!(contact_id: contact.id)
  group.update_attributes!(group_name: hash['group_name'], group_type: hash['group_type'])
  create_role(contact, hash['role1'], hash['role1_leader']) if hash['role1'].present?
  create_role(contact, hash['role2'], hash['role2_leader']) if hash['role2'].present?
end
