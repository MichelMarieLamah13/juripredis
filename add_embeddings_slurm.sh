#!/bin/bash
#SBATCH --job-name=rcc_ae
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --output=add_embeddings_output.log
#SBATCH --error=add_embeddings_error.log
#SBATCH --cpus-per-task=4
#SBATCH --mem=32G

source /etc/profile.d/conda.sh
conda activate rcc

python3 add_embeddings.py

conda deactivate
