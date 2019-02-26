# ***** NETWORK VIZ   ***************************************************
#           Networks using iGraph for actual network construction
#           then using ggnet2 via GGally to create the network as 
#           a ggplot layer.
#           
#           NB: all customisation is therefore done with
#               ggnet2 commands! Not igraph.
#
#           Interweb resources @ bottom.
#
#           TODO: create dummy data df.data
# ***********************************************************************


# *Packages ===============================================================
library( Cairo )        # ggsave to eps with alpha (transparency) levels
library( gridExtra )    # grid.arrange()

library( igraph )   # Construct network objects
library( GGally )   # For ggnet2: turn igraph objects into ggplot objects
                    # Standalone package:
                    # devtools::install_github("briatte/ggnet")
                    # library(ggnet)

# ggnet2 dependencies:
library( network )
library( sna )
library( intergraph )   # optional
# --------------------------------------------------------------------------

# *Create correlation matrix from selected data ====================================================
# Minimum correlations to include
thresh.corr <-  0.4

mat.corr    <-  df.data %>%
                dplyr::select( vars.a, vars.b  ) %>%
                # center / scale data if relevant
                dplyr::mutate_all( funs(as.vector(scale(., scale =  TRUE, center = TRUE))) ) %>%
                na.omit() %>%     
                # calculate correlations
                cor(.) %>%
                as.data.frame(.) %>%
                # Filter correlations below threshhold
                dplyr::mutate_all( funs(replace(., abs(.) < thresh.corr, 0 )) )
# ----------------------------------------------------------------------------------------------------                             

# *Create iGraph network ==============================================================================
net <-  graph_from_adjacency_matrix( as.matrix(mat.corr), weighted = T, mode = "undirected", diag = F )

# Select vertices customise
V(net)$colour[ names(V(net)) %in% vars.setA ] <-  "A"
V(net)$colour[ names(V(net)) %in% vars.setB]  <-  "B"

# Customise edge colours
#   - here by direction of "weight"
E(net)$colour <- ifelse( E(net)$weight >= 0, "#b2994c", "#4d66b3" ) 
# ----------------------------------------------------------------------------------------------------   

# *Plot and save: spring-plots =======================================================================
p.spring    <-  ggnet2( net, 
                        label = TRUE, 
                        label.size = 4, 
                        color = "colour",
                        palette = c( "A" = "#A45684", "B" = "#898989") , 
                        node.size = 10,
                        edge.size = 0.75, 
                        edge.color = "colour",
                        legend.size = 18,
                        legend.position = "bottom", 
                        color.legend = "type" ) + 
                labs( title = paste0("Correlation network with minimum correlation:  ", thresh.corr) ) +
                guides( color = guide_legend() ) + 
                theme(  panel.background = element_rect(color = "grey"),
                        legend.title = element_text( face = "bold", size = 12 ), 
                        legend.text = element_text( size = 12 ) )

# Save plot as .eps
ggsave( paste0( "/path/to/plot/", "plot_dercriptiveName.eps"),
        plot = p.spring,
        width = 15, height = 15, units = c("cm"),
        device = cairo_ps )
# ----------------------------------------------------------------------------------------------------   


# *Plot cirlce layout ================================================================================
p.circ  <-  ggnet2( net, 
                    mode = "circle", 
                    label = TRUE, 
                    label.size = 4, 
                    color = "colr",
                    palette = c( "A" = "#A45684", "B" = "#898989") , 
                    node.size = 10,
                    edge.size = 0.75, edge.color = "grey",
                    legend.size = 18,
                    legend.position = "bottom", 
                    color.legend = "type" ) + 
            labs( title = paste0("Fixed circle!") ) +
            guides( color = guide_legend() ) + 
            theme(  panel.background = element_rect(color = "grey"),
                    legend.title = element_text( face = "bold", size = 12 ), 
                    legend.text = element_text( size = 12 ) )
# ----------------------------------------------------------------------------------------------------



# *Resources ===============================================================

# *iGraph in R
# Beautiful iGraph tutorial:
# http://kateto.net/netscix2016

# *ggnet2
# ggnet2 with inner iGraph object to use with ggplot2:
# https://briatte.github.io/ggnet/

# More options for ggnet2:
# http://www.r-graph-gallery.com/259-custom-your-ggnet2-network-chart/

# ---------------------------------------------------------------------------