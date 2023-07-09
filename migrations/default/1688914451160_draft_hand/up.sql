ALTER TABLE hands ADD COLUMN is_draft boolean DEFAULT TRUE;
ALTER TABLE hands ADD COLUMN modified_date  TIMESTAMP WITH time zone NOT NULL DEFAULT CURRENT_TIMESTAMP;
CREATE TRIGGER set_hand_last_modified BEFORE UPDATE ON public.hands FOR EACH ROW EXECUTE FUNCTION public.set_last_modified();
