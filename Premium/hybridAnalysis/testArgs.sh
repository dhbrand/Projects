#!/bin/bash

var1=10

Rscript ./testArgs.R  $var1 --no-save --no-restore --verbose testArgs.R > output$var1.Rout 2> error$var1.Rout
