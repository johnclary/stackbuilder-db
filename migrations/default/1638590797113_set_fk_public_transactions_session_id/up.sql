alter table "public"."transactions"
  add constraint "transactions_session_id_fkey"
  foreign key ("session_id")
  references "public"."sessions"
  ("id") on update restrict on delete restrict;
