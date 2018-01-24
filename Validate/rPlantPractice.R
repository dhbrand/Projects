require(rPlant)
library(curl)

# A way to hide login details locally
# cat("cyv.pwd=yourpassword\n", file=file.path(normalizePath("~/"), ".Renviron"), append=TRUE)
# cat("cyv.name=dhbrand", file=file.path(normalizePath("~/"), ".Renviron"), append=TRUE)

# Authenticates to API
Validate(Sys.getenv("cyv.name"), Sys.getenv("cyv.pwd"))



# List files in a public directory
ListDir(dir.name="commons_repo/curated/Carolyn_Lawrence_Dill_G2F_Mar_2017/d._2015_inbred_phenotypic_data", shared.username = "shared")

# List apps available
ListApps(description=TRUE)

GetJobHistory()

RetrieveOne <- function(file, archive.path, file.path, print.curl) {  
    # This function takes the file in the archive.path from the iPlant servers
    # to the file.path on the local computer.
    #
    # Args:
    #   file: String of the file name
    #   archive.path: Path to the file on the iPlant server side
    #   file.path: Path to where file will be downloaded on local computer
    #   print.curl: Prints the associated curl statement
    #
    # Returns:
    #   Returns nothing unless an Error
    Time()
    Renew()
    
    web <- paste(rplant.env$webio1, archive.path, "/", file, sep="")
    
    curlPerform(url       = web, 
                curl      = rplant.env$curl.call, 
                writedata = CFILE(file.path(file.path,file), 
                                  mode      = "wrb")@ref)
    gc()
    
    if (print.curl) {
        curl.string <- paste(rplant.env$first, "-X GET", web)
        print(curl.string)
    }
}


ReadFile <- function(file, file.path, print.curl) {
    
                    Time()
                    Renew()
                    
                    web <- paste(rplant.env$webio1, file.path, "/", file, sep="")
           
                    myfile <- getURL( url = web, curl = rplant.env$curl.call )
                    
                    df <- read.csv( textConnection( myfile ), header = TRUE )

}
ReadFile(file = "g2f_2015_inbred_raw_data.csv", 
         file.path = "commons_repo/curated/Carolyn_Lawrence_Dill_G2F_Mar_2017/d._2015_inbred_phenotypic_data" )

test <- curl_fetch_memory()
rplant.env$curl.call


req <- curl_fetch_memory('https://agave.iplantc.org/files/v2/media/dhbrand/Premium/hybrid_g2f_month/hybrid.csv', handle = rplant.env$curl.call)
print(req$status_code)

mirros <- read.csv('mirrors.csv')
unlink('mirrors.csv')