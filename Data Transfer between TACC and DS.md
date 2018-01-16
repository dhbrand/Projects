Agave is a great and very efficient tool for data manipulation.  Below are some examples that should help moving and accessing data in locations on TACC systems (i.e. Stampede2), the Cyverse DataStore, and your local machine (i.e. Windows desktop, Mac laptop).

To use Agave anytime the first step is always to refresh your token.

`auth-tokens-refresh`

Here's a link to the Agave Docmentation on transferring data.
http://developer.agaveapi.co/#transfering-data

While logged into my $WORK directory on TACC I can use Agave to upload a file or directory to my Cyverse DataStore.

`files-upload -V -F AS_ex.map -S data.iplantcollaborative.org dhbrand/AlphaSim`

```
    -V means very Verbose output and is generally not required but included for this example
    -F is the name of the file or directory to be uploaded
    -S is the destination; data.iplantcollaborative.org directs to the Cyverse DataStore and
        from there its just username/directory; the Cyverse DataStore is your default Storage System
        for Agave so typing data.iplantcollaborative.org is not necessary.
```

I can also upload from my personal machine to TACC or the Cyverse DataStore with the same command.

`files-upload -F dongwang.ped dhbrand/ExampleData/`

`files-upload -F dongwang.ped -S tacc-stampede2-dhbrand ExampleData/`

```
    In the second command -S is required. I put tacc-stampede2-dhbrand which is my default
    Execution System and must manually be configured.  This is easily done by following the
    Create TACC Instance guide in the Cyverse-Validate/docs GitHub.
```

You can also see which files are listed in a directory easily.

`files-list dhbrand/AlphaSim`

`files-list -S tacc-stampede2-dhbrand ExampleData/`

```
    This is a quick way go find out if the file you want is in a directory
```
Once you have dicovered the file(s) you require you can get them from the remote location and put them in a local directory.

`files-get dhbrand/AlphaSim/AS_ex.map`

Copied folder from Cyverse DataStore to my current working directory on my local machine.

`files-get -S tacc-stampede2-dhbrand ExampleData/kt.ote`

Copied folder from TACC to my current working directory on my local machine.

You can also import data between to remote locations.

Transferring from TACC $WORK directory to Cyverse DataStore from my local machine.

`files-import -v -U tacc-stampede2-dhbrand getFiles.sh dhbrand/Validate`


Transferring from Cyverse DataStore to TACC $WORK directory from my local machine.

`files-import -v -U dhbrand/DongWang/dongwang.ped -S tacc-stampede2-dhbrand ExampleData/`

You can look at the Systems you have access to and their IDs on Agave ToGo
https://togo.agaveapi.co/auth/#/
