# *TEST for duplicate samples using column of ID's 
#       or any variable that should be unique for each row in data frame
# 
#       with error message pointing to the offending data frame
#           deparse(substitute(...)) : extract name of data frame as character string

test.duplicates <-  function( DF, VEC) {
    if( length(VEC) != length(unique(VEC)) ) stop(paste0('Duplicates in data frame: ', deparse(substitute(DF))) )
}