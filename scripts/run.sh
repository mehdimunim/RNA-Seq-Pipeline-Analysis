
#!/bin/bash
ref_genome=../ref_genome
rnaseq=../rnaseq_reads

annot=$ref_genome/*.gff
ref_fasta=$ref_genome/*.fasta

# loop on all file in RNASEQ 
for file in $rnaseq/*; do
    star.sh $ref_fasta $file $annot 
    samtools.sh 
    htseq.sh
    # rm temp outputs
    done