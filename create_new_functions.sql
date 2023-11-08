-- Create function getemb(kws: text) function

CREATE OR REPLACE FUNCTION getemb_mia23(kws text)
RETURNS vector
LANGUAGE plpgsql
AS $$
DECLARE
    result_vector vector;
BEGIN
    WITH s AS (
        SELECT
            curl_easy_reset(),
            curl_easy_setopt_url('http://127.0.0.1:56002/embed_new?data=' || REPLACE(kws, ' ', '%20')),
            curl_easy_perform(),
            curl_easy_getinfo_data_in()
    )
    SELECT CAST(convert_from(curl_easy_getinfo_data_in, 'utf-8') AS vector(384)) INTO result_vector FROM s;

    RETURN result_vector;
END;
$$;




-- Create function lib_knn(v_query: vecotr, nb: numeric)

CREATE OR REPLACE FUNCTION lib_knn_mia23(v_query vector, nb numeric)
RETURNS SETOF record
LANGUAGE plpgsql
AS $$
BEGIN
    -- Set local configuration variables
    SET LOCAL ivfflat.probes = 65;
    SET LOCAL enable_seqscan = off;
    SET LOCAL min_parallel_table_scan_size = 1;
    SET LOCAL parallel_setup_cost = 1;

    -- Return the query result
    RETURN QUERY
    SELECT J.id_dec, J.chunk, (J.embedding <#> v_query) AS ip, J.passage, J.line
    FROM judilibre_mia23_v AS J
    ORDER BY ip
    LIMIT nb;
END;
$$;



-- Create function lib_v(id: character varying, ch: integer)

CREATE OR REPLACE FUNCTION lib_v_mia23(id character varying, ch integer)
RETURNS vector
LANGUAGE plpgsql
AS $$
DECLARE
    result_vector vector;
BEGIN
    SELECT embedding INTO result_vector
    FROM judilibre_mia23_v
    WHERE id_dec = id AND chunk = ch ;

    RETURN result_vector;
END;
$$;



-- Create function qlib_v_ids(query varchar, nb numeric)

CREATE OR REPLACE FUNCTION qlib_v_ids_mia23(query varchar, nb numeric)
RETURNS SETOF record
LANGUAGE plpgsql
AS $$
BEGIN
    -- Return the query result
    RETURN QUERY
    SELECT J.id_dec, J.chunk, -ts_rank(to_tsvector('french', J.passage), phraseto_tsquery('french', query)) AS ip, J.passage, J.line
    FROM judilibre_mia23_v AS J
    WHERE to_tsvector('french', J.passage) @@ phraseto_tsquery('french', query)
    ORDER BY ip
    LIMIT nb;
END;
$$;


