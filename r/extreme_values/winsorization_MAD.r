# ***** WINSORISE with MAD *********************************
#               MAD: mean absolute deviation
#               WINSORISE: *replace* values outside of 
#                           extreme val threshhold.
#               *Note that classical Winsorisation sets 
#                thresh's at eg. 5% and 95%.
#                Here I adapted to using a MAD cut-off.

#               Winsorisation =/= trimming.

#               Test data block @ bottom. See data/raw/.
# ***********************************************************

# *1. Winsorization (dplyr) ============================================================================
# Outliers / extreme values: Winsorization with MAD setting the threshold, instead of quantile %'s.
fn_winsorizeMAD  <-  function ( VEC, MADdeviations, LOGopt, MADtype ) {
    # Set default MAD argument as "symmetric" - ie will retrun single MAD value.
    MADtype = ifelse( missing(MADtype), "symmetric", MADtype )
    MADtype = ifelse( MADtype != "skew", "symmetric", MADtype )
    # Set default for LOGopt: 0 (ie ignore)
    LOGopt  = ifelse( missing(LOGopt), 0, LOGopt )
    # NB:   LOGopt is not a great idea. 
    #       If I Winsorize in log2-space but return untransformed data, 
    #       some Winsorized points will be lower than the untransformed maximum 
    #       (the same holds for below-medium & minimum values).
    #       Keep code logic for now anyway.

    # fn_MADlimits returns appropriate limits for MADtype. I don't have to do anytihng extra here.

    if (LOGopt == 1) {
        out =   VEC %>%
                replace(., fn_calcMADdist(log2(.)) > MADdeviations & . < median(., na.rm = TRUE),  
                                round(fn_MADlimits(., MADdeviations)[1], 2)  ) %>%
                replace(., fn_calcMADdist(log2(.)) > MADdeviations & . > median(., na.rm = TRUE),  
                                round(fn_MADlimits(., MADdeviations)[2], 2)  )                                 
    } else {
        out =   VEC %>%
                replace(., fn_calcMADdist(.) > MADdeviations & . < median(., na.rm = TRUE),  # below median 
                                round(fn_MADlimits(tmp, MADdeviations)[1], 2)  ) %>%
                replace(., fn_calcMADdist(.) > MADdeviations & . > median(., na.rm = TRUE),  # above median
                                round(fn_MADlimits(., MADdeviations)[2], 2)  )
    }

    return ( out )
} 
# ------------------------------------------------------------------------------------------------


# *TEST *****************************************************************
df.test <-  read.table( "data/raw/test_data.txt", header = TRUE ) %>%
            dplyr::mutate_all( funs(as.numeric(.)) )

# Temporary test vector
tmp <-  df.test$vb


range( fn_winsorizeMAD(tmp, 2, 0, "v"), na.rm = TRUE )

fn_MADlimits( tmp, 2 )
# ----------------------------------------------------------------------


df.test %>%
mutate_at( vars(va), funs(ifelse(LOGopt == 1, replace(., fn_calcMADdist(log2(.)) > MADdeviations,  MADdeviations*fn_calcMAD(log2(.))), 
                                                replace(., fn_calcMADdist(. > MADdeviations,  MADdeviations*fn_calcMAD(.))))) )

df.test %>%
mutate_at( vars(va), funs(ifelse(LOGopt == 1, replace(., fn_calcMADdist(log2(.)) > MADdeviations, 22), 
                                            replace(., fn_calcMADdist(. > MADdeviations,  33)))) )                                           


mutate( OUT = case_when( LOGopt == 1 ~  ) )
# NOT RUN {
# case_when is particularly useful inside mutate when you want to
# create a new variable that relies on a complex combination of existing
# variables
    VEC %>%
    mutate( OUT = case_when(    LOGopt == 1 & fn_calcMADdist(log2(VEC)) > MADdeviations ~ MADdeviations*fn_calcMAD(log2(VEC)),
                                LOGopt == 0 & fn_calcMADdist(VEC) > MADdeviations ~ MADdeviations*fn_calcMAD(log2(VEC),
                                ~ VEC  )



# -------------------------------------------------------------------------------------------------------

# *2. Winsorization (dplyr) ============================================================================
#   Same as above, but with explicit argument if I want to Winsoriaze using the log transformed values, 

fn_winsorizeMAD_logOption  <-  function ( VEC, madDeviations, MADtype ) {

    # Set default MAD argument as "symmetric" - ie will retrun single MAD value.
    MADtype = ifelse( missing(MADtype), "symmetric", MADtype )

    if (MADtype == "skew") {
        MADlower    = median( absDev[VEC <= median(VEC, na.rm = TRUE)], na.rm = TRUE )
        MADupper    = median( absDev[VEC >= median(VEC, na.rm = TRUE)], na.rm = TRUE )
        MADval      = c( MADlower, MADupper )
    } else {
        # Winsorisation: REPLACE extreme values with the appropriate limit
        VEC %<>%    replace( ., fn_calcMADdist(.) > madDeviations, madDeviations*fn_calcMAD(.) ) #WERK, madDeviations*fn_calcMAD(.) nie reg nie
    }

    
    return ( VEC )
} 
# -------------------------------------------------------------------------------------------------------

# *Test*********************************************
# range( tmp, na.rm = TRUE )
# range( fn_winsorizeMAD( tmp, 2 ), na.rm = TRUE )
# -------------------------------------------------



# https://en.wikipedia.org/wiki/Winsorizing

    # Note that winsorizing is not equivalent to simply excluding data, which is a simpler procedure, called trimming or truncation, 
    # but is a method of censoring data.
    # In a trimmed estimator, the extreme values are discarded; in a winsorized estimator, 
    # the extreme values are instead replaced by certain percentiles (the trimmed minimum and maximum). 




# https://en.wikipedia.org/wiki/Median_absolute_deviation

    # In statistics, the median absolute deviation (MAD) is a robust measure of the variability of a univariate sample of quantitative data. 
    # It can also refer to the population parameter that is estimated by the MAD calculated from a sample. 

    # The median absolute deviation is a measure of statistical dispersion. Moreover, the MAD is a robust statistic, being more resilient to outliers 
    # in a data set than the standard deviation. 
    # In the standard deviation, the distances from the mean are squared, so large deviations are weighted more heavily, 
    # and thus outliers can heavily influence it. In the MAD, the deviations of a small number of outliers are irrelevant.

    # Because the MAD is a more robust estimator of scale than the sample variance or standard deviation, 
    # it works better with distributions without a mean or variance, such as the Cauchy distribution. 

    # See also:
    # https://eurekastatistics.com/using-the-median-absolute-deviation-to-find-outliers/