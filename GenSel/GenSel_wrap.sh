#!/bin/bash

# Load inputs/arguments here
# Note that most of these options have been pulled from the GenSel v3 manual
geno_data=${genotypic_data}
pheno_data=${phenotypic_data}
includeRange='${includeRange}'
excludeFilename='${excludeFilename}'
analysisType='${analysisType}'
varGenotypic='${varGenotypic}'
varResidual='${varResidual}'

# No checks on these first two since they are always required 
echo 'markerFileName    $geno_data' >> command_file.txt
echo 'phenotypeFileName         $pheno_data' >> command_file.txt

# Check if the others exist since they are all optional
# May consider adding others depending on the full list of analysis types and arguments
if [ ! -z $includeRange ]; then
        echo 'includeRange      $includeRange' >> command_file.txt
fi

if [ ! -z $excludeFilename ]; then
        echo 'excludeFileName   $excludeFilename' >> command_file.txt
fi

if [ ! -z $analysisType ]; then
        echo 'analysisType      $analysisType' >> command_file.txt
fi

if [ ! -z $varGenotypic ]; then
        echo 'varGenotypic      $varGenotypic' >> command_file.txt
fi

if [ ! -z $analysisType ]; then
        echo 'varResidual       $varResidual' >> command_file.txt
fi

tar -xvf GSrun4.55R.iPlant.tar
export LD_LIBRARY_PATH=:`pwd`/GSrun4.55R/lib
export PATH=$PATH:`pwd`/GSrun4.55R/bin
export PATH=$PATH:`pwd`/GSrun4.55R/lib
#chmod +x GSrun4.55R/bin/GenSel
chmod +x GSrun4.55R/GSsetup
chmod +x GSrun4.55R/bin/GenSel
./GSrun4.55R/GSsetup


# Run the program with the created command file
#chmod +x GSrun4.55R/bin/GenSel
GSrun4.55R/bin/GenSel command_file.txt
