# RNA-Seq-Pipeline-Analysis
 Building a RNA-Seq pipeline analysis for Trichoderma reesei with existing bioinformatics tools.  

## Use
First place the data fastq files in the rnseq_read folder, and the genome and annotation in the ref_genome folder.

Move to scripts

Launch `./run.sh` to get the count of reads for each exon in TSV format.

Finally, launch the R script to get the RNASeq analysis results (DESeq2).

## Requirements
- Fastqc
- Star
- Samtools
- Htseq-count
- R : 
	- DESeq2
	- ReportingTools
