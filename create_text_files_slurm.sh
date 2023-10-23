#!/bin/bash
#SBATCH --job-name=rcc_ctf

conda activate rcc

python3 create_text_files.py

conda deactivate