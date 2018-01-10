#!/bin/bash

#SBATCH -p development
#SBATCH -t 00:30:00
#SBATCH -N 2
#SBATCH -n 4
#SBATCH -A iPlant-Collabs
#SBATCH -J test-premium

R CMD BATCH ./hybrid.R /work/04734/dhbrand/stampede2/Premium/output.txt
