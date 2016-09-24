module ContactsHelper
  def google_link_converter(contact)
    google_address = 'http://maps.google.com/?q=%s,%s,%s,%s' % [
      contact.address_building,
      contact.address_city,
      contact.address_state,
      contact.address_zip
    ]

    link_to google_address, :target => '_blank' do
      '%s, %s, %s %s' % [
        contact.address_building.split.map(&:capitalize).join(' '),
        contact.address_city.split.map(&:capitalize).join(' '),
        contact.address_state,
        contact.address_zip
      ]
    end
  end
end
