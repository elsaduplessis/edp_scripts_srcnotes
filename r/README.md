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




**VISUALISTAION**  

ggplot2
- see cheatsheets

esquisse
- https://github.com/dreamRs/esquisse
- easy interactive GUI plotting for ggplot2

ggplotly
- https://plot.ly/ggplot2/
- Plotly for ggplot


grid

gridExtra
- plot to grids  
- grid.arrange()
- arrangeGrob()

cowplot
- also plotting to grids

**Colour and palettes**

Cairo
- Cairo graphics
- use with ggsave() to enable alpha transparency levels in .eps output

viridis
- palette

wesanderson
- https://github.com/karthik/wesanderson
- palette for reals!
- examples:  
    * https://blog.revolutionanalytics.com/2014/03/give-your-r-charts-that-wes-anderson-style.html

gameofthrones
- https://github.com/aljrico/gameofthrones
- palette
- see "Lady Margaery"


---




**REPORTING**  

knitr
- inter-converts: Rmw - html - tex - pdf
- If using LaTeX for report: 
    * save as .Rnw ("R no web")
    * R block start: << ... >>=, R block end: @ 

xtable
- includes LaTeX longtables  
- some issues with caption at top when not using longtable


---




**METHODS**

**Data QC**  

janitor
- https://github.com/sfirke/janitor
- data cleaning
- examples
    * https://medium.com/@verajosemanuel/janitor-a-good-r-package-for-data-cleaning-f3c733632ad9


naniar  
- http://naniar.njtierney.com/articles/naniar-visualisation.html
- very useful missing data analysis / visualisation

**Extreme value analysis**

extReme
 - http://www.crm.umontreal.ca/2017/Extreme17/pdf/Gilleland_slides.pdf

**Multivariable analyis**

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