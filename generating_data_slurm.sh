#!/bin/bash
#SBATCH --job-name=rcc_gd
#SBATCH --partition=gpu
#SBATCH --time=7-00:00:00
#SBATCH --output=generating_data_output.log
#SBATCH --error=generating_data_error.log
#SBATCH --mem=32G

source /etc/profile.d/conda.sh
conda activate rcc

python3 create_judilibre_v_data.py

conda deactivate
