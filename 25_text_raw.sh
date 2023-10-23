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