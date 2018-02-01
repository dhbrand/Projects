1/4

1. split-apply-combine method to subset weather Data
2. use dataset[,x:y] to subset weather columns in a loop or function

1/8

1. Worked on G2F weather dataset; subset data and accounting for missing obs
2. worked with Austin G on benchmark tool; relayed possible changes for Premium to Silvia
3. Looking at TACC tutorials; trying to build best practice for using R on Stampede2
        a. start with Data Analysis with R on HPC
                i. use names() then attach()
                ii. update tutorials for Stampede2; old stampede1 links and pkgs that are not supported in lated R version
                iii. are we using all of the local cores on our machines
                iv. need to link the profiling tutorial and info on clustering to lab somehow
                v. how to launch R in Stampede2?
4. What are we trying to do with the known-truth simulations for Premium?
5. understanding the way we use Bayesian Clustering and profiling
        a. a profile is the similarities discovered between the covariates
        b. clusters are made and randomly assigned the profiles that were discovered
        c. many iterations of clusters are created using the discovered profiles
        d. we use the clusters with regression to predict future covariates
        e.
6. need to read more about MCMC
7. build solid routine for work

1/9

1. Goals
        a. Run Premium with test code on Stampede2
        b. Complete Slurm Tutorial - Cornell
        c. Learn about SparkR pkg

2. Worked On
        a. cornell Stampede2 tutorial
        b. tested multicore perf on Stampede2
        c. setup RStudio thru TACC Vis Portal for Premium
        d. profiled how long Premium takes for simulation and on Subset_of_Final_Input data
            using local machine and Stampede2 and compared results
        e. reread the Stampede2 User Guide
        f. building a test script to benchmark Premium
        g. using SBATCH/Slurm with R
        h. first chapter of sparkly tutorial
        i. read first set of slides on HDFS from TACC
        j. completed Cornell MapReduce tutorial

3. General Notes
        a. Add Cornell tutorials to Slack
                i. Stampede2 - https://cvw.cac.cornell.edu/Environment/default
        b. Was practicing poor citizendship using login nodes to run R
                i. use the idev command and access a compute node

1/10

1. Goals
        a. Access G2F data on Wrangler using Spark
        b. Use cleaned weather data and run thru Premium
        c. Setup Spark mini-cluster
        d. Read best practice for data transfer
        e. iRods tutorial
        f. CyVerse Youtube videos

2. Worked On
        a. wrangled data and submitted job for hybrids
        b. downloaded spark and tried to run SparkR
                i. had dependecy issues
                ii. had to revert to older version of java
                iii. compiled version of SparkR but only running in terminal
        c. ran through tutorial on sparklyr
        d. practiced moving data with icommands and agave



3. General Notes
        a. Write a report of what got done tomorrow
        b. look up prezzie on gmo's
        c. icommands seems easier than agave

1/11

1. Goals
        a. create an example for students to see different data transfer options
        b. submit hybrid job with remora

2. Worked On
        a. setup remora to run on hybrid job and track perf stats
        b. installed Hive and setup for Spark$
        c. setup Spark mini cluster and test with g2f dataset using SparkR
        d. many problems getting local SparkR to work properly
                i. hive not setup right
                ii. hadoop not compiling native lib
        e. using Kitematic and Docker containers for SparkR

3. General Notes
        a. create an example for transferring files between datastore and TACC

1/15

1. Goals
        a. get hybrid job to complete
                i. max number of cov in plot < 15; subset to only min/max covariates
        b. transfer data between TACC and DS and screenshot
        c. walk thru Validate and notate KT and confusion matrix for Caroline

2. Worked On
        a. trying different types of output in using hybrid/weather data
                i. trying to use Poisson and understand outcomeT(offset) parameter
        b. walking through validate 1.0 documentation step by step
                i. testing steps for AlphaSim
                ii. used getFilesExample.sh for practice
        c. resubmitted job for hybrid with y-normal and no remora
        d. need to add note in Validate readthedocs about copy and paste issues
        e. getting stuck trying to create summary risk plot for Premium
                i. same error every time

3. General Notes
        a. need to look at AlphaSim update to 1.08
                i. test to make sure app works
                ii. publish and retest

1/16

1. Goals
        a. get plot from hybrid job through stampede
        b.

2. Worked On
        a. completed safety courses - EH&S
        b. submitted form for staff id and had ID made
        c. worked with Colin on setting up GitHub; practice commiting and pushing
        d. pushed data transfer tutorial
        e. figured out why premium graph was giving error
                i. cannot have 0 covariate values


3. General Notes
        a. when setting up atom you have to link it to your GitHub
        b.

1/17

1. Goals
        a. make hybrid month subsets more efficient with dplyr
        b. make a script to batch all jobs at once
        c. make correct files or directories ory keys for months
        d. find number of floats to change zeros to in R

2. Worked On
        a. subset data by month
        b. tested locally to fix bugs
        c. tried simply subsetting of months
                i. posted to stackoverflow
        d. tested small nSweeps job on june subset
        e. testing larger nSweeps job on june
        f. figuring out how to use parametric launcher
                i. need to copy launcher.slurm to working dir
                ii. modify like a normal SBATCH script
                iii. make a jobList file in working dir; should just be a list of jobs to run
        g. added pems for MSuggs to use my Execution System for Agave;
                i. now he can run apps I've made that aren't public
        h. certain jobs failed with same plot issues
                i. succesful april, may, june, july, nov, oct

3. General Notes
        a. need to make storage system on mac for Agave
1/18

1. Goals
        a. discover error in Premium tripping NaN'a in plotRiskProfile
        b. run some anaylsis on the inbred data

2. Worked On
        a. the output_mu.txt is completely na's and output_sigma.txt also has na's generated.
                i. any job that has a nan's for mu or signma file will not plot summary correctly
                ii. not sure if this affects the rest of the analysis
        b. create monthly dataframes for inbred data
                i. no yield values for inbred data
        c. worked on importing gbs data
                i. large 3 GB txt file
                ii. had to learn some ways to clean the dataset
                iii. read a regex tutorial that was amazing
                iv. having troubls with the nature of lists within dataframes
                v. trying to follow tidy data principles; all rows as observations and all varialbes as columns
                vi. completed some tidyverse tutorials on datacamp

3. General Notes
        a. read_csv extremely faster than read.read_csv
        b. need to figure out better ways to use apply style functions

1/22

1. Goals
        a. Redo hybrid yield by month analysis
        b. create inbred

2. Worked On
        a. met with Dr. Stapleton to discuss g2f needs
                i. hybrid data with yield, ear height, and plant height by month
                ii. inbred data with ear height and plant height by month
        b. filtered covariates with constant variance in hybrid dataset
        c. tested each new month with nMax = 2 clusters and nSweeps = 10 to error check
                i. march and dec are <500 obs and do not have any non-constant continuous covariates
        d. resubmitted stampede job for april-nov scripts at nSweeps = 1000
        e. cleaned up Project repo for using HPC better
        f. went through weather data with tidy data principles and subset by day
        g. created csv for tidy inbread/weather data

3. General Notes
        a. followup with Agave in R question
        b. followup with replicate in profile regression

1/23

1. Goals
        a. learn about hdf5 data and how to interact in R

2. Worked On
        a. redid the data for hybrids and sent to Silvia
        b. practicing using rhdf5 bioconductor pkg on gbs data
        c. messed with rplant pkg
                i. want a way to read files (csv, txt, etc) directly to data dataframe
                ii. there should be a way to modify rplant pkg code
                iii. requires better understanding of cURL
        d. found an reported an error in readr pkg

3. General Notes
        a. TACC in maintenance today

1/24

1. Goals
        a. submit jobs for hybrid and inbred datasets
        b. test apps in Pipeline
        c. build a script creator function for monthly dataset

2. Worked On
        a. built a function to return covariates with variance for Premium
        b. tested fastlmm, ridge, bayes, & puma
                i. ridge is not working but msuggs is troubleshoot
                ii. fastlmm gives err output; need to open ticket
                iii. puma gives err output; need to fix wrapper and republish
        c. working with rdooley on using Agave inside R
                i. rlang-sdk should allow file transfer to dataframe inside R
        d. optmizing the way to filter constant continuous covs
        e. tested passing command arguments to R scripts
        f. turned profreg by month into single function
                i. easily edit the laucher file for changes to hybrid jobs
                ii.  will be able to subin inbreds changing 1 line


3. General Notes
        1. tring to stand most of the day....sitting 20 min/hr
        2. get directories to print correctly

1/25

1.  Goals
    1. use shell scripts to submit all jobs for inbred and hybrids
2.  Worked On
    1.  having trouble getting scripts to run on HPC
        * looks like #SBATCH -o or -e cannot have a directory in it only file names
        * did not have tidyverse package installed
        * tried using idev to install tidyverse but capped out on 30 min window
        * made an R script and shell script to install tidyverse
    2.  making an app to git pull projects repo on stampede2 using Agave
    3.  making an app to run launcher jobs using jobs-submit
        * need to make a json
        * having trouble resolving app assets
    4.  tidyverse will not install on normal queue
        * trying just dplyr thru idev
    5.  dplyr installed thru login node
        * need to find out if this is bad citizenship
    6.  finally figured out why directories wouldnt create from commandArgs
        * needed to resolve as.integer
    7.  tested the pipeline
        * appears that winnow json creates but agave does not authorize job
        * gemma json is not creating correctly
3.  General Notes
    1.  need to be more clear about data shared
        * original hybrid.csv was not polished
        * need to read about app assets

1/29

1.  Goals
    *   Setup ReadtheDocs for Envirotyping
    *   Setup Envirotyping repo structure
    *   Message Silvia and Susana about ways to work on regular updates and learn the stats behind the Premium package
2.  Worked On
    *   Setup Asana; created Mac App with fluid
    *   Found article on setting up project structure https://jeffknupp.com/blog/2013/08/16/open-sourcing-a-python-project-the-right-way/
    *   Created R
    eadtheDocs account and started setting up site for EnviroTyping
    *   Setup Github for Envirotying and asked for input on Project Structure
    *   Talked with Ramona Wells about data linage
        *   Found a tutorial for RDataTracker provenance utility.  Should work for Premium.
3.  Need to work on task management in the morning.

# Moved to new task management system using HourStack/Asana/Todoist/GoogleCalender stack
