#!/bin/bash
#SBATCH --job-name=rcc_gd
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --output=generating_data_output.log
#SBATCH --error=generating_data_error.log
#SBATCH --mem=32G

source /etc/profile.d/conda.sh
conda activate rcc

# python3 create_judilibre_v_data.py

# awk 'NR == 1 {print; next} FNR > 1' \
# judilibre_v_embeddings_0_975394.tsv judilibre_v_embeddings_975395_1950789.tsv \
# judilibre_v_embeddings_1950790_2926184.tsv judilibre_v_embeddings_2926185_3901579.tsv \
# judilibre_v_embeddings_3901580_4876974.tsv judilibre_v_embeddings_4876975_5852369.tsv \
# judilibre_v_embeddings_5852370_6827764.tsv judilibre_v_embeddings_6827765_7803159.tsv \
# judilibre_v_embeddings_7803160_8778554.tsv judilibre_v_embeddings_8778555_9753949.tsv \
# > judilibre_v/judilibre_v_data.csv

awk 'BEGIN {FS=OFS=","} NR==1 {$2="chunk"} {print}' \
judilibre_v/judilibre_v_data.csv > judilibre_v/judilibre_v_data_new.csv


conda deactivate
