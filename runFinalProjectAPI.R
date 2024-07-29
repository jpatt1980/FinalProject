#runFinalProjectAPI.R

library(plumber)
r <- plumb("FinalProjectAPI.R")

#run it on the port in the Dockerfile
r$run(port=8000)

