#!/bin/bash
#SBATCH --job-name=rcc_ae
#SBATCH --partition=gpu
#SBATCH --time=0-00:00
#SBATCH --output=add_embeddings_output.log
#SBATCH --error=add_embeddings_error.log
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lamahmichelmarie@gmail.com

source /etc/profile.d/conda.sh
conda activate rcc

python3 add_embeddings.py

conda deactivate
