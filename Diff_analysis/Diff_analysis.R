# Analyse différentielle du champignon Trichoderma en utilisant DESeq2
# source : https://bioconductor.riken.jp/packages/3.6/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

## Clean memory
rm(list=ls())


## Install DESeq2 if needed
#if (!require(BiocManager)) install.packages('BiocManager')
#BiocManager::install("DESeq2")
library('DESeq2')

## Input directory
### set projet directory as working directory
if (!require(rstudioapi)) install.packages('rstudioapi')
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
directory <- "../HTSEQ"

## Loading htseq-count files
sampleFiles <- list.files(directory, pattern ="*.tsv")
sampleCondition <- c("glucose","glucose","lactose","lactose")
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

# Building DESEQ2
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)

ddsHTSeq <- DESeq(ddsHTSeq, test = "Wald", fitType = "mean")
## Summarizing results
res <- results(ddsHTSeq , alpha = 0.1)
summary(res)

## MA Plot
plotMA(res, ylim=c(-2,2))