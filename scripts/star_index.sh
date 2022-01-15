#!/bin/bash
echo "STAR: Generating Genome Indexes";
STAR --runThreadN 1 --runMode genomeGenerate --genomeFastaFiles $1 --sjdbGTFfile $2 --sjdbGTFfeatureExon CDS  --sjdbGTFtagExonParentTranscript Parent --outFileNamePrefix ../STAR/ --genomeDir $3
