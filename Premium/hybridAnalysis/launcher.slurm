#!/bin/bash
#
# Simple SLURM script for submitting multiple serial
# jobs (e.g. parametric studies) using a script wrapper
# to launch the jobs.
#
# To use, build the launcher executable and your
# serial application(s) and place them in your WORKDIR
# directory.  Then, edit the CONTROL_FILE to specify
# each executable per process.
#-------------------------------------------------------
#-------------------------------------------------------
#
#         <------ Setup Parameters ------>
#
#SBATCH -J launcherTest
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -p normal
#SBATCH -t 2:00:00
#SBATCH -A Envriotype
#------------------------------------------------------

export LAUNCHER_PLUGIN_DIR=$LAUNCHER_DIR/plugins
export LAUNCHER_RMI=SLURM
export LAUNCHER_JOB_FILE="$WORK/Projects/Premium/hybridAnalysis/launcherTest"

$LAUNCHER_DIR/paramrun
