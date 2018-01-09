!#bin/bash

#SBATCH -p development
#SBATCH -t 00:30:00
#SBATCH -n 15
#SBATCH -A iPlant-Collabs
#SBATCH -J test-premium

R CMD BATCH --slave ./test.R output.txt
