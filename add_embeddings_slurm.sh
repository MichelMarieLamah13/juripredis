#!/bin/bash
#SBATCH --job-name=rcc_ae

conda activate rcc

python3 add_embeddings.py

conda deactivate