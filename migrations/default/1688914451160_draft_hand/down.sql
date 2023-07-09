ALTER TABLE hands DROP COLUMN is_draft;
ALTER TABLE drop COLUMN modified_date;
DROP TRIGGER IF EXISTS set_hand_last_modified on public.hands;
