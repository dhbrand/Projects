#!/bin/sh

#SBATCH -p development
#SBATCH -t 00:30:00
#SBATCH -n 15
#SBATCH -A iPlant-Collabs
#SBATCH -J test-puma

tped="./data/X_test.tped"
tfam="./data/X_test.tfam"
covariate_input="./data/X_cov.txt"
regression="LINEAR"
penalty="LASSO"
name="try1"

. ./puma_wrapper.sh