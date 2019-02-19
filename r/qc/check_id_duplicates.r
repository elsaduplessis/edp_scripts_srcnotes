


#   !TODO automate. This is very manual for the time being.

# *Create test data with multiple ID's ============================================================
df.test <-  data.frame( ID = paste0( "ID", seq(1:32)), VECA = runif(32, 50, 75) ) %>%
            dplyr::mutate_at( vars(ID), funs(replace(., . %in% c("ID30", "ID17") , .[29] ))  ) %>%
            dplyr::mutate_at( vars(ID), funs(replace(., . %in% c("ID1") , .[9] ))  )


# *Extract ID's with duplicates ===================================================================
set.duplicates  <-  df.test %>% 
                    count( ID ) %>% 
                    filter( n > 1 ) %>% 
                    select( ID ) 

# *Create dummy data frame of duplicates so that original data frame is untouched =================
df.dup  <-  df.test  %>% 
            filter( ID %in% set.duplicates$ID ) %>%
            arrange( ID ) %>%
            mutate( rownum = row_number() ) %>%
            select( rownum, everything() )                    


# *Average duplicates manually ====================================================================
row.id29    <-  df.dup %>%
                slice( 1:3 ) %>%
                summarise_at( vars(3:ncol(.)), funs(as.numeric(mean(.)) ) ) %>%
                mutate( ID = df.dup$ID[1] )

row.id9     <-  df.dup %>%
                slice( 4:5 ) %>%
                summarise_at( vars(3:ncol(.)), funs(as.numeric(mean(.)) ) ) %>%
                mutate( ID = df.dup$ID[4] )   


# *Amend original data frame ======================================================================
df.testout  <-  df.test %>%
                dplyr::filter( !(ID %in% set.duplicates$ID) ) %>%    
                full_join( ., row.id9 ) %>%
                full_join( ., row.id29 ) 

dim( df.test )  
dim( unique(df.test) )  

dim( df.testout )
dim( unique(df.testout) )                