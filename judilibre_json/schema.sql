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
-- Name: judilibre_json; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.judilibre_json (
    id character varying(100) NOT NULL,
    json json
);


ALTER TABLE public.judilibre_json OWNER TO postgres;

--
-- Name: judilibre_json judilibre_json_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.judilibre_json
    ADD CONSTRAINT judilibre_json_pkey PRIMARY KEY (id);


--
-- Name: TABLE judilibre_json; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.judilibre_json TO meli;
GRANT ALL ON TABLE public.judilibre_json TO sanjuan;
GRANT ALL ON TABLE public.judilibre_json TO martin;
GRANT SELECT ON TABLE public.judilibre_json TO sd21;
GRANT SELECT ON TABLE public.judilibre_json TO vcod21;
GRANT SELECT ON TABLE public.judilibre_json TO mia23;


--
-- PostgreSQL database dump complete
--

