R packages
---


**READING**  

xlsx

sas7bdat
- SAS data

foreign  
- SPSS data (.sav)
- SPSS date: as.Date(x/86400, origin = "1582-10-14")

memisc
- https://github.com/melff/memisc
- survey data
- import SPSS data
- as.data.set() 
- e.g. *as.data.set(spss.system.file("..."))*


---




**WRANGLING**  

**Tidyverse**

tidyr

dplyr

stringr

broom

magrittr

purr

forcats


**Other**

data.table
- https://github.com/Rdatatable/data.table/wiki
- alternative to tidyverse
- dependencies: base R


---




**DATA QC**  

naniar  
- http://naniar.njtierney.com/articles/naniar-visualisation.html
- very useful NA summaries and visualisation in ggplot


---




**VISUALISTAION**  

ggplot2
- see cheatsheets

esquisse
- https://github.com/dreamRs/esquisse
- easy interactive GUI plotting for ggplot2

grid

gridExtra
- plot to grids  
- grid.arrange()
- arrangeGrob()

cowplot
- also plotting to grids

**Colour and palettes**

viridis

Cairo
- Cairo graphics
- use with ggsave() to enable alpha transparency levels in .eps output


---




**REPORTING**  

knitr

xtable
- includes LaTeX longtables  
- some issues with caption at top when not using longtable


---




**METHODS**

**Multivariable**

Nullabor

GGally
- ggpairs()

igraph
- create network objects

ggnet2
- use igraph network object as base layer for a ggplot

ggnetwork
- similar to ggnet2

ppcor  
- partial correlations

FactoMineR 
- PCA

---