#!/bin/bash
mapped_read="../SAMTOOLS/"$1"_Filtered.sortedByCoord.out.bam"
outpref="../HTSEQ/"$1"_"

echo "Starting HTSEQ"
htseq-count -f bam -r name --type CDS --id ID --stranded reverse $mapped_read $2 > $outpref"Count.tsv"