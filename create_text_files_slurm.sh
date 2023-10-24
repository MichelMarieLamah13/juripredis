#!/bin/bash
#SBATCH --job-name=rcc_ctf
#SBATCH --output=create_text_files_output.log
#SBATCH --error=create_text_files_error.log
#SBATCH --partition=gpu
#SBATCH --time=0-00:00
#SBATCH --mail-type=BEGIN, END
#SBATCH --mail-user=lamahmichelmarie@gmail.com

source /etc/profile.d/conda.sh
conda activate rcc

python3 create_text_files.py

conda deactivate
