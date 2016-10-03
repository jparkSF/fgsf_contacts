class Contact < ActiveRecord::Base
  #before_save :downcase_fields
  belongs_to :user
  before_save :to_i
  has_attached_file :image,
    styles: { large: '600x600#', medium: '300x300#', thumb: '150x150#' },
    default_url: '/assets/:style/default_image.jpg'
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  validates :name, presence: true
  validates :gender, inclusion: { in: %w(male female), message: '%{value} is not a real gender.' }, allow_nil: true

  belongs_to :contact_group, primary_key: :contact_id, foreign_key: :id
  has_one :contact_birthday, primary_key: :id, foreign_key: :contact_id
  has_many :contact_roles, primary_key: :id, foreign_key: :contact_id

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
=begin
  def downcase_fields
    self.name.try(:downcase!)
    self.email.try(:downcase!)
    self.address_building.try(:downcase!)
    self.address_city.try(:downcase!)
    self.other_1.try(:downcase!)
    self.other_2.try(:downcase!)
    self.other_3.try(:downcase!)
  end
=end
   def to_i
     self.address_zip = address_zip.to_i
   end

  def self.search(term)
    contacts = Contact.all.order('created_at DESC')
    contacts.select do |contact|
      contact.attributes.any? { |key, val| val.to_s.include?(term) }
    end
  end

  def male?
    gender == 'male'
  end

  def female?
    gender == 'female'
  end
end
