# Analyse différentielle du champignon Trichoderma en utilisant DESeq2
# source : https://bioconductor.riken.jp/packages/3.6/bioc/vignettes/DESeq2/inst/doc/DESeq2.html

## Clean memory
rm(list = ls())


## Install required packages
#if (!require(BiocManager)) install.packages('BiocManager')
#BiocManager::install("DESeq2")
#BiocManager::install("apeglm")
library('DESeq2')

## Input directory
### set projet directory as working directory
if (!require(rstudioapi))
  install.packages('rstudioapi')
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
directory <- "../HTSEQ"

## Loading htseq-count files
sampleFiles <- list.files(directory, pattern = "*.tsv")
sampleCondition <- c("glucose", "glucose", "lactose", "lactose")
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)
sampleTable$condition <- factor(sampleTable$condition)

# Building DESEQ2
ddsHTSeq <- DESeqDataSetFromHTSeqCount(
  sampleTable = sampleTable,
  directory = directory,
  design = ~ condition
)

ddsHTSeq <-
  DESeq(
    ddsHTSeq,
    test = "Wald",
    fitType = "mean",
    parallel = FALSE,
    BPPARAM = bpparam()
  )
## Summarizing results
res <- results(ddsHTSeq , alpha = 0.1)
summary(res)

## Order results by the smallest p-value
resOrdered <- res[order(res$pvalue),]

## LFC Shrinkage
resLFC <- lfcShrink(ddsHTSeq, coef = 2)


## MA Plot
plotMA(res, ylim = c(-5, 5))
plotMA(resLFC, ylim = c(-5, 5))

## Exporting results
write.csv(as.data.frame(resOrdered),
          file = "Qm6a_Glucose_Lactose_results.csv")