#!/bin/bash
# kill process when error  
set -e
# files and directories 
ref_genome=../ref_genome
rnaseq=../rnaseq_reads
annot=$ref_genome/*.gff
ref_fasta=$ref_genome/*.fasta
genomeDir=../genomeDir

echo "Starting RNASeq Analysis Pipeline"
# generate quality control
./fastqc.sh
# generate genome index for star
./star_index.sh $ref_fasta $annot $genomeDir

# loop on all file in RNASeq
for file in $rnaseq/*; do
    filename=$(basename $file .fastq)
    ./star_map.sh $file $genomeDir
    ./samtools.sh $filename
    ./htseq.sh $filename $annot
    done

# modify TSV by replacing | with _ (needed for R reports)
./edit_tsv.sh

echo "Ending RNASeq Analysis Pipeline"