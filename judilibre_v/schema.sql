--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-2.pgdg120+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-2.pgdg120+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: judilibre_v; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.judilibre_v (
    id_dec character varying(100) NOT NULL,
    chunk integer NOT NULL,
    line integer,
    passage text,
    embedding public.vector(384)
);


ALTER TABLE public.judilibre_v OWNER TO postgres;

--
-- Name: judilibre_v judilibre_v_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.judilibre_v
    ADD CONSTRAINT judilibre_v_pkey PRIMARY KEY (id_dec, chunk);


--
-- Name: judilibre_v_embedding_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX judilibre_v_embedding_idx ON public.judilibre_v USING ivfflat (embedding public.vector_ip_ops) WITH (lists='4211');


--
-- Name: judilibre_v_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX judilibre_v_idx ON public.judilibre_v USING gin (to_tsvector('french'::regconfig, passage));


--
-- Name: TABLE judilibre_v; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.judilibre_v TO martin;
GRANT ALL ON TABLE public.judilibre_v TO sanjuan;
GRANT ALL ON TABLE public.judilibre_v TO meli;
GRANT SELECT ON TABLE public.judilibre_v TO sd21;
GRANT SELECT ON TABLE public.judilibre_v TO vcod21;
GRANT SELECT ON TABLE public.judilibre_v TO mia23;


--
-- PostgreSQL database dump complete
--

