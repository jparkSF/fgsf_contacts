CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "position" varchar, "mok_jang" varchar, "sa_yeok" varchar, "sun_kyo" varchar, "address_building" varchar, "address_city" varchar, "address_zip" varchar, "address_state" varchar, "phone" varchar, "email" varchar, "birthday" date, "other_1" varchar, "other_2" varchar, "other_3" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "image_file_name" varchar, "image_content_type" varchar, "image_file_size" integer, "image_updated_at" datetime, "gender" varchar, "user_id" integer);
CREATE TABLE "contact_groups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "group_type" varchar, "group_name" varchar, "leader" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "contact_birthdays" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "year" integer, "month" integer, "day" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "contact_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "role_name" varchar, "leader" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "email" varchar DEFAULT '' NOT NULL, "encrypted_password" varchar DEFAULT '' NOT NULL, "reset_password_token" varchar, "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar, "last_sign_in_ip" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE TABLE "user_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "role_type" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES ('20160728040424');

INSERT INTO schema_migrations (version) VALUES ('20160816064958');

INSERT INTO schema_migrations (version) VALUES ('20160925025058');

INSERT INTO schema_migrations (version) VALUES ('20160928224944');

INSERT INTO schema_migrations (version) VALUES ('20161003053604');

INSERT INTO schema_migrations (version) VALUES ('20161003234507');

