

# Outliers / extreme values: Winsorization with MAD setting the threshold, instead of quantile %'s.
fn_winsorizeWithMAD <-  function ( xvec, madDeviations ) {
            # Number of MAD deviations sets extreme value threshold
            madLimit    = mad( xvec, na.rm = TRUE ) * madDeviations
            
            upperLim    = median( xvec, na.rm = TRUE ) + madLimit
            lowerLim    = median( xvec, na.rm = TRUE ) - madLimit
            
            # Winsorisation: REPLACE these values with the appropriate limit
            #               ( trimming implies removal, not replacement )
            xvec[xvec > upperLim]   = upperLim
            xvec[xvec < lowerLim]   = lowerLim  

            return (xvec)
} 



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