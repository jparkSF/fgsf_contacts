class Contact < ActiveRecord::Base

    before_save :downcase_fields
    has_attached_file :image, styles: { large: "600x600#", medium: "300x300#", thumb: "150x150#" },
                :default_url => "/assets/:style/default_image.jpg"
    validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

    def self.to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |contact|
            csv << contact.attributes.values_at(*column_names)
        end
      end
    end



  #  validates :name, :phone, :presence => true
  #  validates :name, :length => { :minimum => 2}


   def downcase_fields
        self.name.downcase!
        self.email.downcase!
        self.address_building.downcase!
        self.address_city.downcase!
        self.other_1.downcase!
        self.other_2.downcase!
        self.other_3.downcase!
   end

   def phone=(phone)
   write_attribute(:phone, phone.gsub(/\D/, ''))
   end

   def self.search(search)
Contact.where("name LIKE ? OR
                    position LIKE ? OR
                    mok_jang LIKE ? OR
                    sa_yeok LIKE ? OR
                    sun_kyo LIKE ? OR
                    address_building LIKE ? OR
                    address_city LIKE ? OR
                    address_zip LIKE ? OR
                    address_state LIKE ? OR
                    phone LIKE ? OR
                    birthday LIKE ? OR
                    email LIKE ? OR
                    other_1 LIKE ? OR
                    other_2 LIKE ? OR
                    other_3 LIKE ?", "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%",
                    "%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%","%#{search}%",
                    "%#{search}%")


    end
end
