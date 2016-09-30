CREATE TABLE "schema_migrations" ("version" varchar NOT NULL);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
CREATE TABLE "contacts" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "position" varchar, "mok_jang" varchar, "sa_yeok" varchar, "sun_kyo" varchar, "address_building" varchar, "address_city" varchar, "address_zip" varchar, "address_state" varchar, "phone" varchar, "email" varchar, "birthday" date, "other_1" varchar, "other_2" varchar, "other_3" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "image_file_name" varchar, "image_content_type" varchar, "image_file_size" integer, "image_updated_at" datetime, "gender" varchar);
CREATE TABLE "contact_groups" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "group_type" varchar, "group_name" varchar, "leader" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "contact_birthdays" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "year" integer, "month" integer, "day" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "contact_roles" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "contact_id" integer, "role_name" varchar, "leader" boolean, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO schema_migrations (version) VALUES ('20160728040424');

INSERT INTO schema_migrations (version) VALUES ('20160816064958');

INSERT INTO schema_migrations (version) VALUES ('20160925025058');

