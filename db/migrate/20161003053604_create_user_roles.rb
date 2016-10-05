# frozen_string_literal: true
class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.integer :user_id
      t.string :role_type

      t.timestamps null: false
    end
  end
end
