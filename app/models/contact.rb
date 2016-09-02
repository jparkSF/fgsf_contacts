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

    def self.import(file)
      spreadsheet = open_spreadsheet(file)
      header = spreadsheet.row(1)
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        contact = find_by_id(row["id"]) || new
        contact.attributes = row.to_hash
        contact.save!
      end
    end

    def self.open_spreadsheet(file)

        case File.extname(file.original_filename)
        when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
        when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
        when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
        else raise "Unknown file type: #{file.original_filename}"
        end

    end




   def downcase_fields
        self.name.downcase!
        self.email.downcase!
        self.address_building.downcase!
        self.address_city.downcase!
        self.other_1.downcase!
        self.other_2.downcase!
        self.other_3.downcase!
   end

   #def phone=(phone)
   # write_attribute(:phone, phone.gsub(/\D/, ''))
   #end


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
