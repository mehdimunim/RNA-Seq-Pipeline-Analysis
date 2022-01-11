#!/bin/bash

projet=..;
ref_fasta=$projet/ref_genome/*.fasta;
rnaseq=$projet/rnaseq_reads 
genomeDir=$projet/genomeDir;
annot=$projet/ref_genome/*.gff;

echo "Starting STAR";

echo "Generating Genome Indexes";
STAR --runThreadN 1 --sjdbGTFfile $annot --sjdbGTFfeatureExon CDS  --sjdbGTFtagExonParentTranscript Parent --runMode genomeGenerate --genomeDir $genomeDir  --genomeFastaFiles $ref_fasta;

echo "Mapping RNASeq reads to genome";
STAR --runThreadN 1 --genomeDir $genomeDir --readFilesIn $rnaseq/$1 --outSAMtype BAM SortedByCoordinate;