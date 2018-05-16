#!/bin/bash
WRAPPERDIR="$( cd "$( dirname "$0" )" && pwd )"
chmod +x qxpak_wrapper.sh

export pedigree_file=${"test/qxpak_1.ped"}
export marker_file=${"test/qxpak_1.mkr"}
export data_file=${"qxpak_1.dat"}
export parameter_file=${"qxpak_1.par"}
export output=${"Test"}

./qxpak_wrapper.sh
