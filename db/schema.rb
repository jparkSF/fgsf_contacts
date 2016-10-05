# encoding: UTF-8
# frozen_string_literal: true
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_160_928_225_803) do
  create_table 'contact_birthdays', force: :cascade do |t|
    t.integer  'contact_id'
    t.integer  'year'
    t.integer  'month'
    t.integer  'day'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contact_groups', force: :cascade do |t|
    t.integer  'contact_id'
    t.string   'group_type'
    t.string   'group_name'
    t.boolean  'leader'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contact_roles', force: :cascade do |t|
    t.integer  'contact_id'
    t.string   'role_name'
    t.boolean  'leader'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'contacts', force: :cascade do |t|
    t.string   'name'
    t.string   'position'
    t.string   'mok_jang'
    t.string   'sa_yeok'
    t.string   'sun_kyo'
    t.string   'address_building'
    t.string   'address_city'
    t.string   'address_zip'
    t.string   'address_state'
    t.string   'phone'
    t.string   'email'
    t.date     'birthday'
    t.string   'other_1'
    t.string   'other_2'
    t.string   'other_3'
    t.datetime 'created_at',         null: false
    t.datetime 'updated_at',         null: false
    t.string   'image_file_name'
    t.string   'image_content_type'
    t.integer  'image_file_size'
    t.datetime 'image_updated_at'
    t.string   'gender'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'email',                  default: '', null: false
    t.string   'encrypted_password',     default: '', null: false
    t.string   'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer  'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string   'current_sign_in_ip'
    t.string   'last_sign_in_ip'
    t.datetime 'created_at',                          null: false
    t.datetime 'updated_at',                          null: false
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true
  add_index 'users', ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
end
