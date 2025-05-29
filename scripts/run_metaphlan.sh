#!/bin/bash
set -euo pipefail

# === Directories ===
IN_DIR=~/Kvass_project/data/processed/host_filtered_reads
OUT_DIR=~/Kvass_project/results/metaphlan

mkdir -p "$OUT_DIR"

# === Loop over all R1 filtered reads ===
for R1 in "$IN_DIR"/*_R1.filtered.fq.gz; do
    SAMPLE=$(basename "$R1" _R1.filtered.fq.gz)
    R2="$IN_DIR/${SAMPLE}_R2.filtered.fq.gz"
    OUTPUT="$OUT_DIR/${SAMPLE}_profile.txt"
    BOWTIE2_OUT="$OUT_DIR/${SAMPLE}_bt2.bz2"

    if [[ -f "$R2" ]]; then
        echo "▶ Running MetaPhlAn on $SAMPLE"

        metaphlan "$R1","$R2" \
            --input_type fastq \
            --bowtie2out "$BOWTIE2_OUT" \
            --nproc 32 \
            -o "$OUTPUT"

        echo "✅ Finished: $SAMPLE"
    else
        echo "⚠️  Missing R2 for $SAMPLE — skipping"
    fi
done

echo "🎉 All samples processed with MetaPhlAn."

