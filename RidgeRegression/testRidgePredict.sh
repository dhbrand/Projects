#!/bin/bash

WRAPPERDIR=$( cd "$( dirname "$0" )" && pwd )

#SBATCH -p development
#SBATCH -t 00:30:00
#SBATCH -n 15
#SBATCH -A iPlant-Collabs 
#SBATCH -J test-ridgepredict

inputPed="$WRAPPERDIR/example.ped"
outputPed="$WRAPPERDIR/exampleOut.ped"

chmod +x ./wrapper.sh

./wrapper.sh

