# Select all unique IDs and store them in an array
unique_ids=($(psql -d juripredis -t -c "SELECT DISTINCT id FROM your_table"))

# Loop through the unique IDs and select related values
for id in "${unique_ids[@]}"; do
    # Use psql to run a query for each ID
    query="SELECT * FROM your_table WHERE id = '$id';"
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "$query"
done



ssh mia23@iutdev.univ-avignon.fr -p 54322
Vatuc@CERIe7

ssh mia2307@iutdev.univ-avignon.fr
Vatuc@CERIe7


psql -d juripredis -c "\copy (SELECT DISTINCT json->>'id' from judilibre_json) TO STDOUT" |  ssh mia2307@iutdev.univ-avignon.fr 'cat > all_ids.tsv'


unique_ids=($(psql -d juripredis -t -c "SELECT DISTINCT id FROM your_table"))

# Loop through the unique IDs and select related values
for id in "${unique_ids[@]}"; do
    # Use psql to run a query for each ID
    query="SELECT * FROM your_table WHERE id = '$id';"
    psql -h $DB_HOST -p $DB_PORT -U $DB_USER -d $DB_NAME -c "$query"
done

unique_ids=('JURITEXT64252c84c0b6bd04f5cfdaa7' 'JURITEXT642fb5ebcece1704f574748b' 'JURITEXT6388564301d0fb05d44b0c18' 'JURITEXT64019dc6546e3305deed5b90' 'JURITEXT6163402c7dbf94c22343ca75')

unique_ids=(
'JURITEXT6332932d0fe3af05da3236b0'
'JURITEXT642d1487cb8fa004f57da1dd'
'JURITEXT648d4ed994daad05db3582e3'
'JURITEXT642fb5eccece1704f5747491'
'JURITEXT64841562c24155d0f832f9b6'
'JURITEXT638af5b574406805d4118e82'
'JURITEXT6163873c947dd77ae6de0264'
'JURITEXT646f012c3fdabad0f888ec39'
'JURITEXT648021f7f17e00d0f8b5746e'
'JURITEXT632565838c3b842d4d9c0aaa'
'JURITEXT63918cf66d1e4f05d4f67b15'
'JURITEXT6253c879bd3db21cbdd85606'
'JURITEXT645dd9ced1cd71d0f8286794'
'JURITEXT6253c99fbd3db21cbdd88d0e'
'JURITEXT648175315025cbd0f8b68441'
'JURITEXT642e6400826f3a04f52168f9'
'JURITEXT643a430fd83dbd04f5fb2c03'
'JURITEXT63cf8478a6687f7c904cba2d'
'JURITEXT6400506b4e741a05de652bc9'
'JURITEXT6162887ddafa129e399519c7'
'JURITEXT63edd77b865b2505dee64cb3'
'JURITEXT646713a1b1f82ad0f8d9f91a'
'JURITEXT6455f00a6d2f7dd0f861bf5b'
'JURITEXT64437b9c823e6dd0f8bf803c'
'JURITEXT63ff0297002ac605de15b669'
)
for id in "${unique_ids[@]}"; do
    # Use psql to run a query for each ID
    psql -d juripredis -c "\copy (select json_array_elements_text(json->'raw_text') from judilibre_json where json->>'id' = '${id}') TO STDOUT" |  ssh mia2307@iutdev.univ-avignon.fr "cat > juritext/${id}.tsv"
done

scp -P 54322 25_text_raw.sh  mia23@iutdev.univ-avignon.fr:./
Vatuc@CERIe7

ssh mia23@iutdev.univ-avignon.fr -p 54322
Vatuc@CERIe7

ssh mia2307@iutdev.univ-avignon.fr
Vatuc@CERIe7

25_text_raw.sh

scp JURITEXT648d4ed994daad05db3582e3.tsv

unique_ids=(
'JURITEXT646713a1b1f82ad0f8d9f91a.tsv'
'JURITEXT646f012c3fdabad0f888ec39.tsv'
'JURITEXT648021f7f17e00d0f8b5746e.tsv'
'JURITEXT648175315025cbd0f8b68441.tsv'
'JURITEXT64841562c24155d0f832f9b6.tsv'
'JURITEXT648d4ed994daad05db3582e3.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  mia23@iutdev.univ-avignon.fr:judilibre_json/${id}  ./judilibre_json
done


unique_ids=(
'JURITEXT646713a1b1f82ad0f8d9f91a'
'JURITEXT646f012c3fdabad0f888ec39'
'JURITEXT648021f7f17e00d0f8b5746e'
'JURITEXT648175315025cbd0f8b68441'
'JURITEXT64841562c24155d0f832f9b6'
'JURITEXT648d4ed994daad05db3582e3'
)
for id in "${unique_ids[@]}"; do
    psql -d juripredis -c "\copy (select chunk, line,  passage, embedding  from judilibre_v where id_dec='${id}') TO STDOUT" |  ssh mia2307@iutdev.univ-avignon.fr "cat > judilibre_v/${id}.tsv"
done


unique_ids=(
'JURITEXT646713a1b1f82ad0f8d9f91a.tsv'
'JURITEXT646f012c3fdabad0f888ec39.tsv'
'JURITEXT648021f7f17e00d0f8b5746e.tsv'
'JURITEXT648175315025cbd0f8b68441.tsv'
'JURITEXT64841562c24155d0f832f9b6.tsv'
'JURITEXT648d4ed994daad05db3582e3.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  mia2307@iutdev.univ-avignon.fr:judilibre_v/${id}  ./judilibre_v
done



ssh mia2304@iutdev.univ-avignon.fr
Vatuc@CERIe7

unique_ids=(
'JURITEXT642fb5ebcece1704f574748b.tsv'
'JURITEXT642fb5eccece1704f5747491.tsv'
'JURITEXT643a430fd83dbd04f5fb2c03.tsv'
'JURITEXT64437b9c823e6dd0f8bf803c.tsv'
'JURITEXT6455f00a6d2f7dd0f861bf5b.tsv'
'JURITEXT645dd9ced1cd71d0f8286794.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  ./judilibre_json/${id} mia2304@iutdev.univ-avignon.fr:judilibre_json/${id}
done

Vatuc@CERIe7


ssh mia2308@iutdev.univ-avignon.fr
Vatuc@CERIe7
unique_ids=(
'JURITEXT63ff0297002ac605de15b669.tsv '
'JURITEXT6400506b4e741a05de652bc9.tsv'
'JURITEXT64019dc6546e3305deed5b90.tsv'
'JURITEXT64252c84c0b6bd04f5cfdaa7.tsv'
'JURITEXT642d1487cb8fa004f57da1dd.tsv'
'JURITEXT642e6400826f3a04f52168f9.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  ./judilibre_json/${id} mia2308@iutdev.univ-avignon.fr:judilibre_json/${id}
done

Vatuc@CERIe7

unique_ids=(
'JURITEXT6332932d0fe3af05da3236b0.tsv'
'JURITEXT6388564301d0fb05d44b0c18.tsv'
'JURITEXT638af5b574406805d4118e82.tsv'
'JURITEXT63918cf66d1e4f05d4f67b15.tsv'
'JURITEXT63cf8478a6687f7c904cba2d.tsv'
'JURITEXT63edd77b865b2505dee64cb3.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  mia2316@iutdev.univ-avignon.fr:judilibre_json/${id}  ./judilibre_json
done

Vatuc@CERIe7

unique_ids=(
'JURITEXT6162887ddafa129e399519c7.tsv'
'JURITEXT6163402c7dbf94c22343ca75.tsv'
'JURITEXT6163873c947dd77ae6de0264.tsv'
'JURITEXT6253c879bd3db21cbdd85606.tsv'
'JURITEXT6253c99fbd3db21cbdd88d0e.tsv'
'JURITEXT632565838c3b842d4d9c0aaa.tsv'
)

for id in "${unique_ids[@]}"; do
    scp  mia2316@iutdev.univ-avignon.fr:judilibre_json/${id}  ./judilibre_json
done

Vatuc@CERIe7


psql -d juripredis -c "\copy (select json_array_elements_text(json->'raw_text') from judilibre_json where json->>'id' = '${id}') TO STDOUT" |  ssh mia2307@iutdev.univ-avignon.fr "cat > juritext/${id}.tsv"

ssh mmlamah@zephyr.univ-avignon.fr
ssh mmlamah@aphrodite.univ-avignon.fr
1810@Miguel@Marie@Lamah@2023

scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/db.sql ./
scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/juripredis_struct.sql ./

line_count=$(wc -l < mmlamah/all_ids.tsv)
counter=1
while IFS=$'\t' read -r id; do
    psql -d juripredis -c "\copy (select json_array_elements_text(json->'raw_text') from judilibre_json where json->>'id' = '${id}') TO STDOUT" > "mmlamah/judilibre_json/${id}.tsv"
    echo "[${counter} / ${line_count}] done"
    counter=$((counter + 1))
done < mmlamah/all_ids.tsv

counter=1
line_count=$(wc -l < ids.tsv)
while read -r id; do
  echo "[$counter / $line_count] done"
  counter=$((counter + 1))
done < ids.tsv

file = "ids.tsv"
line_count=$(wc -l < ids.tsv)
echo "$line_count"

113423
wc -l < mmlamah/judilibre_json/

30
ls -1 mmlamah/judilibre_json/ | wc -l

psql -d juripredis
pg_dump  -d juripredis -f mmlamah/db.sql


pg_dump -d juripredis -t judilibre_json -f mmlamah.sql
Vatuc@CERIe7


pg_dump -d juripredis -t judilibre_json -f mmlamah/judilibre_json.sql
Vatuc@CERIe7

psql -d juripredis -c "\copy (select json->>'id' as id, json_array_elements_text(json->'raw_text') as raw_text from judilibre_json) TO STDOUT" > "mmlamah/judilibre_json.tsv"

scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/judilibre_json.sql ./

pg_dump -d juripredis -t judilibre_json --schema-only -f mmlamah/judilibre_json_schema.sql

pg_dump -d juripredis -t judilibre_v --schema-only -f mmlamah/judilibre_v_schema.sql

scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/judilibre_json_schema.sql ./judilibre_json/schema.sql

scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/judilibre_json_schema.sql ./judilibre_json/data.sql

Vatuc@CERIe7

pg_dump -d juripredis -t judilibre_json -f mmlamah/judilibre_json_data.sql

scp  -P 54322  mia23@iutdev.univ-avignon.fr:mmlamah/judilibre_json_data.sql ./judilibre_json/data.sql

scp -r mia2307@iutdev.univ-avignon.fr:judilibre_json ./judilibre_json/

scp  -P 54322  mia23@iutdev.univ-avignon.fr:judilibre_v_schema.sql ./judilibre_v/schema.sql