alter table "public"."venues" add column "is_deleted" boolean
 not null default 'false';
