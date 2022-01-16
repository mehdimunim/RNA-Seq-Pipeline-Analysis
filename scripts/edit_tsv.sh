#!/bin/bash
for file in ../HTSEQ/*.tsv; do
    outputfile="../counts/Filtered_"$(basename $file)
    echo "filter "$file
    # change from per exon to per gene count  
    sed 's/|.*\t/\t/' $file \
    | awk '{arr[$1]+=$2} END {for (key in arr) printf("%s\t%s\n", key, arr[key])}' | sort -k1,1 > $outputfile;
    done