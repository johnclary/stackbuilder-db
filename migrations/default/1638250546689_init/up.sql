SET check_function_bodies = false;
CREATE FUNCTION public.set_last_modified() RETURNS trigger
    LANGUAGE plpgsql
    AS $$ BEGIN NEW.modified_date := NOW();
RETURN NEW;
END;
$$;
CREATE TABLE public.blinds (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.blinds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.blinds_id_seq OWNED BY public.blinds.id;
CREATE TABLE public.game_types (
    id integer NOT NULL,
    name text NOT NULL
);
ALTER TABLE public.game_types ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.game_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
CREATE TABLE public.games (
    id integer NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    game_type_id integer NOT NULL,
    is_tourney boolean DEFAULT false,
    is_deleted boolean DEFAULT false,
    user_id text NOT NULL,
    venue_id integer NOT NULL,
    start_date timestamp with time zone DEFAULT now() NOT NULL,
    end_date timestamp with time zone,
    entry integer NOT NULL,
    blind_id integer,
    limit_id integer DEFAULT 0
);
ALTER TABLE public.games ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.games_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
CREATE TABLE public.limits (
    id integer NOT NULL,
    name text NOT NULL
);
CREATE SEQUENCE public.limits_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.limits_id_seq OWNED BY public.limits.id;
CREATE TABLE public.transactions (
    id integer NOT NULL,
    created_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    txn_date timestamp with time zone DEFAULT now() NOT NULL,
    modified_date timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    comment text,
    inbound boolean DEFAULT false,
    amount integer NOT NULL,
    is_deleted boolean DEFAULT false,
    game_id integer NOT NULL,
    user_id text NOT NULL
);
ALTER TABLE public.transactions ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
CREATE TABLE public.users (
    id integer NOT NULL,
    user_id text NOT NULL,
    last_seen timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    name text NOT NULL
);
ALTER TABLE public.users ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
CREATE TABLE public.venues (
    id integer NOT NULL,
    name text NOT NULL,
    user_id text NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);
CREATE SEQUENCE public.venues_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.venues_id_seq OWNED BY public.venues.id;
ALTER TABLE ONLY public.blinds ALTER COLUMN id SET DEFAULT nextval('public.blinds_id_seq'::regclass);
ALTER TABLE ONLY public.limits ALTER COLUMN id SET DEFAULT nextval('public.limits_id_seq'::regclass);
ALTER TABLE ONLY public.venues ALTER COLUMN id SET DEFAULT nextval('public.venues_id_seq'::regclass);
ALTER TABLE ONLY public.blinds
    ADD CONSTRAINT blinds_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.game_types
    ADD CONSTRAINT game_types_name_key UNIQUE (name);
ALTER TABLE ONLY public.game_types
    ADD CONSTRAINT game_types_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.limits
    ADD CONSTRAINT limits_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_user_id_key UNIQUE (user_id);
ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_pkey PRIMARY KEY (id);
CREATE INDEX games_user_id_pkey ON public.games USING btree (user_id);
CREATE INDEX transactions_game_id_pkey ON public.transactions USING btree (game_id);
CREATE INDEX venues_updated_at_btree ON public.venues USING btree (updated_at);
CREATE TRIGGER set_game_last_modified BEFORE INSERT OR UPDATE ON public.games FOR EACH ROW EXECUTE FUNCTION public.set_last_modified();
CREATE TRIGGER set_txn_last_modified BEFORE INSERT OR UPDATE ON public.transactions FOR EACH ROW EXECUTE FUNCTION public.set_last_modified();
ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_game_id FOREIGN KEY (game_id) REFERENCES public.games(id);
ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_game_type FOREIGN KEY (game_type_id) REFERENCES public.game_types(id);
ALTER TABLE ONLY public.games
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public.users(user_id);
ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_blind_id_fkey FOREIGN KEY (blind_id) REFERENCES public.blinds(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_limit_id_fkey FOREIGN KEY (limit_id) REFERENCES public.limits(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_venue_id_fkey FOREIGN KEY (venue_id) REFERENCES public.venues(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ONLY public.venues
    ADD CONSTRAINT venues_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(user_id) ON UPDATE RESTRICT ON DELETE RESTRICT;
