### MULTIPLE USEFUL TESTS 
#   to use as sanity checks throughout analyses

# *Test number of samples.
#   Input: global scalar (desired sample size) 
test.n <-  function( DF, sizeN ) {
    if( dim(DF)[1] != sizeN ) 
        stop( paste0('Data frame sample size: ', dim(DF)[1], ". Doesn't equal ", sizeN, ".") )
}