#!/bin/bash
echo "Starting samtools"
echo "Map and filter BAM file" 
samtools view -b -F 4 ../STAR/*.bam > Mapped.sortedByCoord.out.bam
samtools view -b -q 30 Mapped.sortedByCoord.out.bam > Filtered.sortedByCoord.out.bam

echo "Generate BAI index file" 
samtools index Filtered.sortedByCoord.out.bam