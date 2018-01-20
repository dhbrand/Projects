Accomplished

1. worked with Premium pkg in depth
        a. able to get some results subset hybrid data with weather subsets
        b. keep incurring the same error with plotRiskProfile
        c. appears to be isolated in the C++ code creating NaNs in the mu and sigma files
2. after getting comfortable with premium working on batching jobs for the diff months
        a. the help guide on the parametric launcher is confusing
                i. you have to load the module in TACC
                ii. copy the launcher.slurm file and edit for your sbatch needs
                iii. create a file with the commands to run each jobs
                iv. direct the launcher.slurm file to your multiple job file
                v. execute with sbatch launcher.Slurm
        b. had success sending small jobs with month hybrid data
                i. send some issues to Silvia regarding plot issues
                ii. results are on my DataStore
3. worked on Validate some with MSuggs
        a. he had pems for Winnow app but not private execution system
                i. learned how to add user to ExSys for testing
        b. updated some documention for the Pipeline
                i. need to push but dont understand rst yet
4. started working on cleaning the gbs data
        a. the file is large so I  subset to 100 rows to try and clean the dataset
        b. had trouble with splitting the elements on certain characters the way i wanted
                i. I now understand what regular expressions are and how to filter strings with them
        c. able to get column names from elements
        d. was having trouble extracting all obs from column heads
                i. trying to follow tidy practices with some tidyverse tutorials
                ii. got the data cleaned but will not write to read_csv
                iii. there are ~100 obs over 20 variables
5. Ran through the whole Validate workflow
        a. getting ready for questions newcomers might have
        b. my shell scripting skills make it easier to understand everything
                i. realized how little of what I was doing I actually understood last year
        c. would like to explore simulate python files

Goals

1. work with dr. Stapleton to see what we can do with gbs dataset; types of analysis
2. keep testing Validate pipeline as MSuggs fixes bugs
        a. get the documentation updated
3. Learn about lists within data dataframes
4. Publish AlpahSim 1.08
        a. should be ready to go just need a few tests and have soemone else test as well


Blocks

1. the problems with plotRiskProfile; receiving very intermittent communication from Silvia
2. understanding how the data structure imports into R affects runtime
3. better understanding of applying tidy data techniques to our data
