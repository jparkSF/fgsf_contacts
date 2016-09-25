class Contact < ActiveRecord::Base
  before_save :downcase_fields

  has_attached_file :image,
    styles: { large: '600x600#', medium: '300x300#', thumb: '150x150#' },
    default_url: '/assets/:style/default_image.jpg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true

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
      when '.csv'
        Roo::Csv.new(file.path, nil, :ignore)
      when '.xls'
        Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx'
        Roo::Excelx.new(file.path, nil, :ignore)
      else
        raise "Unknown file type: #{file.original_filename}"
    end
  end

  def downcase_fields
    self.name.try(:downcase!)
    self.email.try(:downcase!)
    self.address_building.try(:downcase!)
    self.address_city.try(:downcase!)
    self.other_1.try(:downcase!)
    self.other_2.try(:downcase!)
    self.other_3.try(:downcase!)
  end

   def self.search(term)
     contacts = Contact.all.order('created_at DESC')
     contacts.select do |contact|
       contact.attributes.any? { |key, val| val.to_s.include?(term) }
     end
   end
end
