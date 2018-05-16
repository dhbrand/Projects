#!/bin/bash

chmod +x ./puma/puma
chmod +x ./puma/extract_puma_results.R

geno=${tped}
pheno=${tfam}
sex=${sex}
covariate=${covariates}
regression=${regression}
sma=${sma}
penalty=${penalty}
name=${name}
screen=${screen_p_value}
pml=${pML_restarts}
folder=${results}
threads=${nthreads}
restricted=${restrictedPathSearch}

ARGS=""

#regex to ensure TPED and TFAM
genoRe=".*\.tped"
phenoRe=".*\.tfam"
covRe=".*\.txt"
regRe="^(LINEAR|LOGISTIC)$"
penaltyRe="^(LASSO|ALASSO|LOG|NEG|MCP|VBAY|\s)+$"

if [ -z $geno ] || [[ ! $geno =~ $genoRe ]]; then
        echo "Must provide genotype input file in .tped format"
else
        ARGS="${ARGS} --tped $geno"
fi

if [ -z $pheno ] || [[ ! $pheno =~ $phenoRe ]]; then
        echo "Must provide phenotype input file in .tfam format"
else
        ARGS="${ARGS} --tfam $pheno"
fi

if [ ! -z $sex ]; then
        ARGS="${ARGS} --sex"
fi

if [ ! -z $covariate ] && [[ ! $covariate =~ $covRe ]]; then
        echo "Covariates must be submitted as a text file storing a matrix with each column being a covariate"
elif [ ! -z $covariate ] && [[ $covariate =~ $covRe ]]; then
        ARGS="${ARGS} --covariates $covariate"
fi

if [ -z $regression ] || [[ ! $regression =~ $regRe ]]; then
        echo "Must provide regression model as either LINEAR or LOGISTIC"
else
        ARGS="${ARGS} --regression $regression"
fi

if [ ! -z $sma ]; then
        ARGS="${ARGS} --sma"
fi

if [ -z $penalty ] || [[ ! $penalty =~ $penaltyRe ]]; then
        echo "Must provide space delimited list of penalty methods to run, select from: LASSO ALASSO LOG NEG MCP VBAY"
else
        ARGS="${ARGS} --penalty $penalty"
fi

if [ -z $name ]; then
        echo "Must provide name to be appended to results files"
else
        ARGS="${ARGS} --name $name"
fi

if [ ! -z $screen ]; then
        ARGS="${ARGS} --screen_p_value $screen"
fi

if [ ! -z $pml ]; then
        ARGS="${ARGS} --pML_restarts $pml"
fi

if [ ! -z $folder ]; then
        ARGS="${ARGS} --results $folder"
fi

if [ ! -z $threads ]; then
        ARGS="${ARGS} --nthreads $threads"
fi

if [ ! -z $restricted ]; then
        ARGS="${ARGS} --restrictedPathSearch"
fi

echo "Arguments: "
echo "./puma/puma ${ARGS}"
echo "Starting Puma"
./puma/puma ${ARGS}
