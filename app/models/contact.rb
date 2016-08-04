class Contact < ActiveRecord::Base

    before_save :downcase_fields

    #validates :name, :phone, :presence => true
    #validates :name, :length => { :minimum => 2}


     def downcase_fields
        self.name.capitalize!
        self.email.downcase!
        self.address_building.downcase!
        self.address_city.downcase!
        self.other_1.downcase!
        self.other_2.downcase!
        self.other_3.downcase!

   end

end
