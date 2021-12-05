alter table "public"."venues" alter column "is_hidden" set default false;
alter table "public"."venues" alter column "is_hidden" drop not null;
alter table "public"."venues" add column "is_hidden" bool;
