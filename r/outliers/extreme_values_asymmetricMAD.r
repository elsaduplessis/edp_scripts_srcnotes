

# *1. Calculate Absolute deviation from median  ==================================================
fn_absDev  <-  function ( VEC ) {

    # Return vector of absolute deviations from vector median per entry
    absDev  = abs( VEC - median(VEC, na.rm = TRUE) )

    return ( absDev )
} 
# ------------------------------------------------------------------------------------------------


# *2. Calculate MAD distance(s) from median  ====================================================
fn_calcMAD  <-  function ( VEC, MADtype ) {
    
    # Set default MAD argument as "symmetric" - ie will retrun single MAD value.
    MADtype = ifelse( missing(MADtype), "symmetric", MADtype )

    # Calculate absolute deviations from MEDIAN
    absDev  = fn_absDev( VEC )
    
    # Test wether to do MAD adapted for skewed distribution or not.
    # Default is classical MAD for normal distribution.
    # "skew" as argument will calculate two MAD-values for below-median and above-median portions.
    if (MADtype == "skew") {
        MADlower    = median( absDev[VEC <= median(VEC, na.rm = TRUE)], na.rm = TRUE )
        MADupper    = median( absDev[VEC >= median(VEC, na.rm = TRUE)], na.rm = TRUE )
        MADval      = c( MADlower, MADupper )
    } else {
        MADval      = median( absDev, na.rm = TRUE )
    }

    return ( MADval )
} 
# ------------------------------------------------------------------------------------------------


# *3. Calculate MAD vector for above/below median  ===============================================
fn_calcMADvec  <- function ( VEC, MADtype ) {
    
    # Call inner functions to caluclate absolute deviations and MAD values(s)
    MADvalue    = fn_calcMAD( VEC, MADtype )

    # Create vector with applicable MAD parameter for each entry (below/above median)
    #   (i) assign first entry of MAD to all, so that the next line is applicable for
    #           symmetric distributions, too
    MADvec  = rep( MADvalue[1], length(VEC) )
    #   (ii) if skew distribution specified: amend above-median deviations
    if (length(MADvalue) == 2) {
        MADvec[VEC > median(VEC, na.rm = TRUE)]   = MADvalue[2]
    }
    
    return( MADvec )
}
# -----------------------------------------------------------------------------------------------


# *4. Calculate MAD distance(s) from median  ====================================================
#       Finally
fn_calcMADdist  <- function ( VEC, MADtype ) {

    # Set default MAD argument as "symmetric" - ie will retrun single MAD value.
    MADtype = ifelse( missing(MADtype), "symmetric", MADtype )
    
    # Call inner functions to caluclate absolute deviations and MAD values(s)
    MADvec      = fn_calcMADvec( VEC, MADtype )

    # Calculate the MAD distance for every point
    #   NA's: okay, because MADvec contains at least default MADvalue, therefore no /NA.
    MADdist     = abs(VEC - median(VEC, na.rm = TRUE)) / MADvec

    # Deal with median explicitly (distance should be zero)
    MADdist[VEC == median(VEC, na.rm = TRUE)] = 0
    
    return( MADdist )
}
# ------------------------------------------------------------------------------------------------


# *TEST *****************************************************************
df.test <-  read.table( "data/raw/test_data.txt", header = TRUE ) %>%
            dplyr::mutate_all( funs(as.numeric(.)) )

# Temporary test vector
tmp <-  df.test$vb


#  1. 
fn_absDev( tmp ) 

# 2.
fn_calcMAD( tmp )

# 3. 
fn_calcMADvec( tmp )

# 4.
fn_calcMADdist( tmp )
fn_calcMADdist( tmp, "skew" )

# Median of all MAD distances should be 1:
median( fn_calcMADdist(df.test$vb), na.rm = TRUE )
median( fn_calcMADdist(df.test$vb, "skew"), na.rm = TRUE )
# ----------------------------------------------------------------------


                


# ADAPTED FROM:

# https://eurekastatistics.com/using-the-median-absolute-deviation-to-find-outliers/

#     One more thing. If more than 50% of your data have identical values, your MAD will equal zero. All points in your dataset except those that equal the median will then be flagged as outliers, regardless of the level at which you've set your outlier cutoff. (By constrast, if you use the standard-deviations-from-mean approach to finding outliers, Chebyshev's inequality puts a hard limit on the percentage of points that may be flagged as outliers.) So at the very least check that you don't have too many identical data points before using the MAD to flag outliers.

#     My DoubleMADsFromMedian() function, above, deals with this problem via its zero.mad.action parameter:

#         If zero.mad.action is "stop" and the left MAD or the right MAD is 0, execution halts.
#         If zero.mad.action is "warn" and the left (right) MAD is 0, a warning is thrown. All points to the left (right) of the median will have a MAD-denominated distance from median of Inf.
#         If zero.mad.action is "na" and the left (right) MAD is 0, all points to the left (right) of the median will have a MAD-denominated distance from median of NA.
#         If zero.mad.action is "warn and na" and the left (right) MAD is 0, a warning is thrown. All points to the left (right) of the median will have a MAD-denominated distance from median of NA.


        # DoubleMAD <- function(x, zero.mad.action="warn"){
        #    # The zero.mad.action determines the action in the event of an MAD of zero.
        #    # Possible values: "stop", "warn", "na" and "warn and na".
        #    x         <- x[!is.na(x)]
        #    m         <- median(x)
        #    abs.dev   <- abs(x - m)
        #    left.mad  <- median(abs.dev[x<=m])
        #    right.mad <- median(abs.dev[x>=m])
        #    if (left.mad == 0 || right.mad == 0){
        #       if (zero.mad.action == "stop") stop("MAD is 0")
        #       if (zero.mad.action %in% c("warn", "warn and na")) warning("MAD is 0")
        #       if (zero.mad.action %in% c(  "na", "warn and na")){
        #          if (left.mad  == 0) left.mad  <- NA
        #          if (right.mad == 0) right.mad <- NA
        #       }
        #    }
        #    return(c(left.mad, right.mad))
        # }

        # DoubleMADsFromMedian <- function(x, zero.mad.action="warn"){
        #    # The zero.mad.action determines the action in the event of an MAD of zero.
        #    # Possible values: "stop", "warn", "na" and "warn and na".
        #    two.sided.mad <- DoubleMAD(x, zero.mad.action)
        #    m <- median(x, na.rm=TRUE)
        #    x.mad <- rep(two.sided.mad[1], length(x))
        #    x.mad[x > m] <- two.sided.mad[2]
        #    mad.distance <- abs(x - m) / x.mad
        #    mad.distance[x==m] <- 0
        #    return(mad.distance)
        # }