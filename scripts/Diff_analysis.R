# Analyse différentielle du champignon Trichoderma en utilisant DESeq2
# sources : https://bioconductor.riken.jp/packages/3.6/bioc/vignettes/DESeq2/inst/doc/DESeq2.html
#           https://bioconductor.org/packages/release/bioc/vignettes/ReportingTools/inst/doc/rnaseqAnalysis.pdf
## Clean memory
rm(list = ls())


## Install required packages
#if (!require(BiocManager)) install.packages('BiocManager')
#BiocManager::install("DESeq2")
#BiocManager::install("apeglm")
#if (!require(rstudioapi))
#install.packages('rstudioapi')
library(DESeq2)
library(ReportingTools)

## Input directory
### set projet directory as working directory
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
directory <- "../counts"

## Loading htseq-count files
sampleFiles <- list.files(directory, pattern = "*.tsv")
sampleCondition <- c("glucose", "glucose", "lactose", "lactose")
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)
### the reference level is glucose as is it before lactose in the alphabetic order
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
pCutoff <- 0.05
res <- results(ddsHTSeq , alpha = pCutoff, lfcThreshold = 2, altHypothesis = "greater")
summary(res)

## Order results by the smallest p-value
resOrdered <- res[order(res$pvalue),]

## LFC Shrinkage
#resLFC <- lfcShrink(ddsHTSeq, coef = 2)

## MA Plot with shrinkage
plotMA(res, main = "MA Plot", ylim = c(-16, 16))


## Exporting results tO CSV
write.csv(as.data.frame(resOrdered),
          file = "../reports/Qm6a_Glucose_Lactose_results.csv")

## Writing report
des2Report <- HTMLReport(shortName = 'RNAseq_analysis_with_DESeq2', title = 'RNA-seq analysis of differential expression using DESeq2', reportDirectory = "../reports")
publish(ddsHTSeq,des2Report, pvalueCutoff=pCutoff, annotation.db="org.Mm.eg.db", factor = colData(ddsHTSeq)$condition,reportDir="../reports")
finish(des2Report)

