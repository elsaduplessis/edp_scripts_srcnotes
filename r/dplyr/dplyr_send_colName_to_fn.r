
### *A solution presents itself:

require( dplyr )
require( ggplot2 )

# *1. Test simple function =============================
fn_test <-  function( DF, COLNAME ) {
    tmpName =   enquo( COLNAME )

    df.out  =   DF %>%
                dplyr::select( !!tmpName )
                
    return ( df.out )
}

df.tmp  <-  data.frame( colA = 1:4, columnOddName = c("A", "h", "o", "y"), colB = 5:8 )

fn_test( df.tmp, columnOddName )
# -----------------------------------------------------



# *2. Test with ggplot ================================
fn_testFig <-  function( DF, VECA, VECB ) {
    nameA   <-  enquo( VECA )
    nameB   <-  enquo( VECB )

    p.out   <-  DF %>%
                ggplot( aes(x = !!nameA, y = !!nameB) ) + 
                geom_point( colour = "#cc00cc", size = 4 ) + 
                labs( title = "success" )
                
    return ( p.out )
}

fn_testFig( df.tmp, colA, colB )
# -----------------------------------------------------



# *SOURCE of WISDOM ===================================

# See last comment with latest dplyr updates:
# https://stackoverflow.com/questions/28973056/in-r-pass-column-name-as-argument-and-use-it-in-function-with-dplyrmutate-a

        # With the devel version of dplyr (0.5.0) or in the new version (0.6.0 - awaiting release in April 2017), this can be done using slightly different syntax

        # library(dplyr)
        # funcN <- function(dat, varname){
        #  expr <- enquo(varname)
        #  dat %>%
        #      mutate(v3 = sum(!!expr))
        #      #or
        #      #mutate(v3 = sum(UQ(expr)))

        # } 

        # funcN(data, v1)
        # #  v1 v2 v3
        # #1  1  3  3
        # #2  2  4  3

        # Here, enquo takes the arguments and returns the value as a quosure (similar to substitute in base R) by evaluating the function arguments lazily and inside the summarise, we ask it to unquote (!! or UQ) so that it gets evaluated.
        # shareimprove this answer
        # answered Apr 14 '17 at 20:17
        # akrun
        # 405k13196269



