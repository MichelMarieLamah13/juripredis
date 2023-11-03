#!/bin/bash
#SBATCH --job-name=rcc_ae
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --output=add_embeddings_output.log
#SBATCH --error=add_embeddings_error.log
#SBATCH --cpus-per-task=5
#SBATCH --array=1-10

source /etc/profile.d/conda.sh
conda activate rcc

python3 add_embeddings.py --batch_index=$SLURM_ARRAY_TASK_ID

conda deactivate
