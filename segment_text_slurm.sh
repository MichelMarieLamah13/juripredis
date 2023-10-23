#!/bin/bash
#SBATCH --job-name=rcc_st

conda activate rcc

python3 segment_text.py

conda deactivate