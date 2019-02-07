# ***** PLOT:   *********************************************
#               panel of MAD distances and compare with 
#               raw data and histogram/density.
#               Also include log2( data ).
#               LHS: raw data
#               RHS: log2( data )
#               Row 1: histograms
#               Row 2: raw data by index
#               Row 3: MAD distances (median should be 1)
#               Row 4: asymmetric MAD distances

#               Test data block @ bottom. See data/raw/.
# ***********************************************************

fn_plotVar_MAddistances     <-  function ( DF, VARNAME ) {
    var         =   enquo( VARNAME )

    p.hist      =   DF %>%     
                    mutate( dfvar = !!var ) %>% 
                    ggplot( aes(x = dfvar) ) + 
                    geom_histogram( aes(y = ..density..),      # Histogram with density instead of count on y-axis
                                    # binwidth = 0.2, 
                                    # bins = 50,
                                    colour = "black", fill = "white") +
                    geom_density( alpha = 0.2, fill="#FF6666" ) +
                    labs( x = "", y = "", title = var )

    p.histlog   =   DF %>%     
                    mutate( dfvar = log2(!!var) ) %>%
                    ggplot( aes(x = dfvar) ) + 
                    geom_histogram( aes(y = ..density..),      # Histogram with density instead of count on y-axis
                                    # binwidth = 0.2, 
                                    # bins = 50,
                                    colour = "black", fill = "white") +
                    geom_density( alpha = 0.2, fill = "#47b2b2" ) +
                    labs( x = "", y = "", title = "log2 transformed" )    

    p.vec       =   DF %>%     
                    mutate( dfvar = !!var ) %>%
                    ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                    geom_point() + 
                    labs( x = "", y = var )

    p.veclog    =   DF %>%     
                    mutate( dfvar = log2(!!var) ) %>%
                    ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                    geom_point() + 
                    labs( x = "", y = "log2" )            

    p.mad       =   DF %>%     
                    mutate( dfvar = fn_calcMADdist(!!var) ) %>%
                    ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                    geom_point( aes(colour = cut(dfvar, c(0, 3, 4, Inf)) ) ) + 
                    scale_color_manual( values = c('grey', 'orange', 'red'), guide = FALSE ) +
                    labs( x = "", y = "MAD distance" ) + 
                    theme( panel.background = element_rect( fill = "#fff4f2",
                                                            colour = "#fff4f2",
                                                            size = 0.5, linetype = "solid") )

    p.madlog    =   DF %>%     
                    mutate( dfvar =  fn_calcMADdist(log2(!!var)) ) %>%
                    ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                    geom_point( aes(colour = cut(dfvar, c(0, 3, 4, Inf)) ) ) + 
                    scale_color_manual( values = c('grey', 'orange', 'red'), guide = FALSE ) +
                    labs( x = "", y = "MAD distance" )  + 
                    theme( panel.background = element_rect( fill = "#fff4f2",
                                                            colour = "#fff4f2",
                                                            size = 0.5, linetype = "solid") )

    p.madskew       =   DF %>%     
                        mutate( dfvar = fn_calcMADdist(!!var, "skew") ) %>%
                        ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                        geom_point( aes(colour = cut(dfvar, c(0, 3, 4, Inf)) ) ) + 
                        scale_color_manual( values = c('grey', 'orange', 'red'), guide = FALSE ) +
                        labs( x = "index", y = "Skew MAD distance" )  + 
                        theme( panel.background = element_rect( fill = "#f0fff0",
                                                                colour = "#f0fff0",
                                                                size = 0.5, linetype = "solid") )

    p.madlogskew    =   DF %>%     
                        mutate( dfvar = fn_calcMADdist(log2(!!var), "skew") ) %>%
                        ggplot( aes(x = seq_along(dfvar), y = dfvar) ) + 
                        geom_point( aes(colour = cut(dfvar, c(0, 3, 4, Inf)) ) ) + 
                        scale_color_manual( values = c('grey', 'orange', 'red'), guide = FALSE ) +
                        labs( x = "index", y = "Skew MAD distance" )     + 
                        theme( panel.background = element_rect( fill = "#f0fff0",
                                                                colour = "#f0fff0",
                                                                size = 0.5, linetype = "solid") )                     

    return ( grid.arrange(   p.hist, p.histlog, p.vec, p.veclog, 
                             p.mad, p.madlog, p.madskew, p.madlogskew, 
                             ncol = 2, heights = c( 0.75, 1, 1, 1) ) )
}
# ------------------------------------------------------------------------------------------------


# *TEST ****************************************************
#   Use test_data in data/raw/

df.test <-  read.table( "data/raw/test_data.txt", header = TRUE ) %>%
            dplyr::mutate_all( funs(as.numeric(.)) )


fn_plotVar_MAddistances( df.test, ve )

fn_plotVar_MAddistances( df.test, va )
# ----------------------------------------------------------df.bev$
