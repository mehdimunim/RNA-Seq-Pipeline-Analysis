#!/bin/bash
echo "Mapping RNASeq reads to genome";
STAR --runThreadN 6 --readFilesIn $1 --genomeDir $2  --outFileNamePrefix ../STAR/ --outSAMtype BAM SortedByCoordinate