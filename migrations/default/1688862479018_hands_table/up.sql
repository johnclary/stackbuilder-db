CREATE TABLE hands (
    id serial PRIMARY KEY,
    hand jsonb,
    session_id integer REFERENCES sessions (id) ON UPDATE CASCADE ON DELETE SET NULL,
    user_id text REFERENCES users (user_id) NOT NULL,
    created_date TIMESTAMP WITH time zone NOT NULL DEFAULT CURRENT_TIMESTAMP
);
