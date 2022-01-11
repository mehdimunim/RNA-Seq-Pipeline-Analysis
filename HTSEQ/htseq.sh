#!/bin/bash
projet=..;
annot=$projet/ref_genome/*.gff;
mapped_read=$projet/SAMTOOLS/Filtered.sortedByCoord.out.bam

echo "Starting HTSEQ"
htseq-count -f bam -r name --type CDS --id ID --stranded reverse $mapped_read $annot > Count.tsv