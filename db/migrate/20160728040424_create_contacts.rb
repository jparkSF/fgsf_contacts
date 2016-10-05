# frozen_string_literal: true
class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :position
      t.string :mok_jang
      t.string :sa_yeok
      t.string :sun_kyo
      t.string :address_building
      t.string :address_city
      t.string :address_zip
      t.string :address_state
      t.string :phone
      t.string :email
      t.date :birthday
      t.string :other_1
      t.string :other_2
      t.string :other_3

      t.timestamps null: false
    end
  end
end
