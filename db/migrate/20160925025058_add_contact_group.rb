# frozen_string_literal: true
class AddContactGroup < ActiveRecord::Migration
  def change
    add_column :contacts, :gender, :string

    create_table :contact_groups do |t|
      t.integer :contact_id
      t.string :group_type
      t.string :group_name
      t.boolean :leader

      t.timestamps null: false
    end

    create_table :contact_birthdays do |t|
      t.integer :contact_id
      t.integer :year
      t.integer :month
      t.integer :day

      t.timestamps null: false
    end

    create_table :contact_roles do |t|
      t.integer :contact_id
      t.string :role_name
      t.boolean :leader

      t.timestamps null: false
    end
  end
end
