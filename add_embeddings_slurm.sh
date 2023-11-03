#!/bin/bash
#SBATCH --job-name=rcc_ae
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --output=add_embeddings_output_%A_%a.log
#SBATCH --error=add_embeddings_error_%A_%a.log
#SBATCH --cpus-per-task=5
#SBATCH --mem=32G
#SBATCH --array=1-2

source /etc/profile.d/conda.sh
conda activate rcc

python3 add_embeddings.py --batch_index=$SLURM_ARRAY_TASK_ID

conda deactivate
