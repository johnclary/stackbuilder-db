
alter table "public"."sessions" alter column "is_deleted" set default 'false';

ALTER TABLE "public"."sessions" ALTER COLUMN "is_deleted" drop default;

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."sessions" add column "is_deleted" boolean
--  not null;

alter table "public"."sessions" drop constraint "sessions_user_id_fkey";

-- Could not auto-generate a down migration.
-- Please write an appropriate down migration for the SQL below:
-- alter table "public"."sessions" add column "user_id" text
--  not null;

DROP TABLE "public"."sessions";
