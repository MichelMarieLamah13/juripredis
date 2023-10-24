#!/bin/bash
#SBATCH --job-name=rcc_st
#SBATCH --partition=gpu
#SBATCH --time=0-00:00
#SBATCH --output=segment_text_output.log
#SBATCH --error=segment_text_error.log
#SBATCH --mail-type=BEGIN,END
#SBATCH --mail-user=lamahmichelmarie@gmail.com


source /etc/profile.d/conda.sh
conda activate rcc

python3 segment_text.py

conda deactivate
