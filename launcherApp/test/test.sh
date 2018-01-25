#!/bin/bash

#SBATCH -p development
#SBATCH -t 00:30:00
#SBATCH -n 1
#SBATCH -A EnvrioType
#SBATCH -J test-launcherApp

filename=./launcher.slurm

#Now to execute the main program
sbatch $filename
