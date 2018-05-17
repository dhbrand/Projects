#!/bin/bash

chmod +x ./wrapper.sh

gfile="../examples/lsa.geno"
npop=1


./wrapper.sh $npop $gfile
