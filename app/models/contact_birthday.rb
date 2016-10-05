class ContactBirthday < ActiveRecord::Base
  belongs_to :contact, primary_key: :id, foreign_key: :contact_id

  YEAR_LIMIT = 1982

  def self.contact_birthdays
    hash = {}
    birth_years = ContactBirthday.pluck(:year).uniq.sort.reverse
    birth_years.reject! { |y| y < YEAR_LIMIT }
    birth_years.each do |year|
      hash[year] = ContactBirthday.where(year: year)
    end
    hash['>1982'] = ContactBirthday.where('year < ?', YEAR_LIMIT)
    hash
  end
end
