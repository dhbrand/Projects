#!/bin/bash
#set -x
WRAPPERDIR=$( cd "$( dirname "$0" )" && pwd )
chmod +x gemma-wrap.sh

PLINK=1
inputBED="$WRAPPERDIR/test/mouse_hs1940.bed"
inputBIM="$WRAPPERDIR/test/mouse_hs1940.bim"
inputFAM="$WRAPPERDIR/test/mouse_hs1940.fam"
Type=1
output="gemma-test1"
gk=1

./gemma-wrap.sh
