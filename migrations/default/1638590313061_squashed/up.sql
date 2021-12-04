
CREATE TABLE "public"."sessions" ("id" serial NOT NULL, "game_id" integer NOT NULL, PRIMARY KEY ("id") , FOREIGN KEY ("game_id") REFERENCES "public"."games"("id") ON UPDATE restrict ON DELETE restrict, UNIQUE ("id"));

alter table "public"."sessions" add column "user_id" text
 not null;

alter table "public"."sessions"
  add constraint "sessions_user_id_fkey"
  foreign key ("user_id")
  references "public"."users"
  ("user_id") on update restrict on delete restrict;

alter table "public"."sessions" add column "is_deleted" boolean
 not null;

alter table "public"."sessions" alter column "is_deleted" set default 'false';

alter table "public"."sessions" alter column "is_deleted" set default 'False';
