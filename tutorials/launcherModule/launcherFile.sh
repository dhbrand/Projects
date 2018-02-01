#! /bin/bash

#read csv filenames into an array and them pass them to a file ready for launcher module on stampede2

# change to directory with csv's
cd randcsv/

i=0
while read line
do
    array[ $i ]="$line"
    (( i++ ))
done < <(ls)


for i in "${array[@]}"
do
    # substitues csv filename for $i and sends output and error from R to respective files
    echo "Rscript --vanilla --verbose headDF.R > output.Rout 2> error.Rout $i"
done > ../launcherFile
