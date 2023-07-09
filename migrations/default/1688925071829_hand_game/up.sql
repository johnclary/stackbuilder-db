ALTER TABLE hands
    ADD COLUMN game_id integer;

ALTER TABLE hands
    ADD CONSTRAINT hand_game_id_pk FOREIGN KEY (game_id) REFERENCES games (id) ON
            UPDATE
                CASCADE ON DELETE SET NULL;
