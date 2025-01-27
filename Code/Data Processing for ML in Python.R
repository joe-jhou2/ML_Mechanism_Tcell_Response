setwd("/Users/jhou2/Documents/GitHub/HSV434-IFNG-mechanism")

library(Seurat)
library(dplyr)
library(xlsx)

load("/Users/jhou2/Documents/GitHub/HSV434-Landscape/ProcessedData/HSV434_integrated_Lev3_Tcell.Rdata")

# setup default assay
DefaultAssay(HSV434_integrated_Lev3_Tcell) = "RNA" 

# Select subset focus on CM/EM and other effector T cells
HSV434_integrated_Lev3_Tcell_sel = subset(HSV434_integrated_Lev3_Tcell, 
                                          subset = CellType_Level3 %in% c("CD4 CM", "CD4 EM 1", "CD4 EM 2", "CD4 EM 3", 
                                                                          "CD4 TRM", "CD4 ISG", "CD4 Act", "CD4 Prolif", 
                                                                          "CD8 CM", "CD8 EM 1", "CD8 EM 2", 
                                                                          "CD8 TRM 1", "CD8 TRM 2", "CD8 ISG"), invert = FALSE)
# extract normalized data
exp_data = HSV434_integrated_Lev3_Tcell_sel[["RNA"]]$data
exp_data = exp_data[rowSums(exp_data) > 0,]

# Fetch meta data
meta_data = HSV434_integrated_Lev3_Tcell_sel@meta.data[,c('orig.ident', 'Batch', 
                                                          'Subject', 'Status',
                                                          'CellType_Level3')]

# Stitch expression and meta data in python, exp_data too big here
write.csv(exp_data, file = "ProcessedData/HSV434_Tcell_IFNG_mechanism_exp_data.csv", row.names = TRUE)
write.csv(meta_data, file = "ProcessedData/HSV434_Tcell_IFNG_mechanism_meta_data.csv", row.names = TRUE)

