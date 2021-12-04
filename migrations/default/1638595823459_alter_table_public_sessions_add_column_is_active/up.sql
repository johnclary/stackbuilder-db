alter table "public"."sessions" add column "is_active" boolean
 not null default 'true';
