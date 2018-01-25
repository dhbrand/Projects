#!/bin/bash

folder=${folder}

filename=${filename}

cd $folder

sbatch $filename
