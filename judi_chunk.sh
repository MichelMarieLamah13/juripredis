#!/bin/bash

# Check if the argument is provided
if [ -z "$1" ]; then
    echo "Please provide the table name as an argument."
    exit 1
fi

table=$1
psql -d juripredis -c "\copy (select id, json_array_elements_text(json->'raw_text') from "$table"_json) TO STDOUT" \

QUERY_RESULT=$(psql -U $DB_USER -h $DB_HOST -d $DB_NAME -c "SELECT * FROM $1")

ssh mia23@iutdev.univ-avignon.fr -p 54322

