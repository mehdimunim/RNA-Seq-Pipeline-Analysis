#!/bin/bash
pref="../SAMTOOLS/"$1"_"
echo "Starting samtools"
echo "Map and filter BAM file" 
samtools view -b -F 4 ../STAR/Aligned.sortedByCoord.out.bam > $pref"Mapped.sortedByCoord.out.bam"
samtools view -b -q 30 $pref"Mapped.sortedByCoord.out.bam" > $pref"Filtered.sortedByCoord.out.bam"

echo "Generate BAI index file" 
samtools index $pref"Filtered.sortedByCoord.out.bam"