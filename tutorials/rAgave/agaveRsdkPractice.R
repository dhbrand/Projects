# library(devtools)
# install_github("agaveplatform/r-sdk")
library(rAgave)

# cat("AGAVE_USERNAME=dhbrand\n", file=file.path(normalizePath("~/"), ".Renviron"))
# cat("AGAVE_PASSWORD=password\n", file=file.path(normalizePath("~/"), ".Renviron"), append=TRUE)
# cat("AGAVE_TENANT=iplantc.org\n", file=file.path(normalizePath("~/"), ".Renviron"), append=TRUE)
# cat("AGAVE_BASE_URL=https://agave.iplantc.org", file=file.path(normalizePath("~/"), ".Renviron"), append=TRUE)

myCreds <- Sys.getenv( c("AGAVE_USERNAME", "AGAVE_PASSWORD", "AGAVE_TENANT", "AGAVE_BASE_URL"), names = TRUE )

# if (is.null(myCreds[["AGAVE_USERNAME"]]) || nchar(myCreds[["AGAVE_USERNAME"]]) == 0) {
#     myCreds[["AGAVE_USERNAME"]] <- readline("Agave username:")
#     Sys.setenv(AGAVE_USERNAME = myCreds[["AGAVE_USERNAME"]])
# }
# 
# if (is.null(myCreds[["AGAVE_PASSWORD"]]) || nchar(myCreds[["AGAVE_PASSWORD"]]) == 0) {
#     myCreds[["AGAVE_PASSWORD"]] <- readline("Agave password:")
#     Sys.setenv(AGAVE_PASSWORD = myCreds[["AGAVE_PASSWORD"]])
# }
# 
# if (is.null(myCreds[["AGAVE_BASE_URL"]]) || nchar(myCreds[["AGAVE_BASE_URL"]]) == 0) {
#     myCreds[["AGAVE_BASE_URL"]] <- readline("Agave base url (https://public.agaveapi.co):")
#     Sys.setenv(AGAVE_BASE_URL = myCreds[["AGAVE_BASE_URL"]])
# }

ag <-Agave$new( baseUrl = myCreds[["AGAVE_BASE_URL"]],
                username = myCreds[["AGAVE_USERNAME"]], 
                password = myCreds[["AGAVE_PASSWORD"]])


str(ag$tokenInfo$toJSON())

profile <- ag$profiles$getProfile(username="me")
str(profile)

c(ag$clientInfo$key, ag$tokenInfo$access_token, ag$tenantInfo$baseUrl)

str(Agave$public_fields)

clientData <- Client$new(clientName = 'rAgave')
ag$clients$add_client(body=clientData)$content

ag$clients$create(body=list(clientName = 'rAgave'))

str(head(ag$apps$listApps(),5))
str(ag$files$list(path = "dhbrand/ExampleData/DongWang/"))

ag$clients$list_clients()

ag$files$download(destSystemId = "data.iplantcollaborative", path = "agave://data.iplantcollaborative.org/dhbrand/ExampleData/DongWang/",filename = "dongwang.ped")

