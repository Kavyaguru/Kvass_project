#!/bin/bash
  
READ_DIR=~/Kvass_project/data/processed/trimmed_reads
OUT_DIR=~/Kvass_project/data/processed/host_withhuman_filtered_reads
HOST_INDEX=~/Kvass_project/genomes/combined_hosts

mkdir -p "$OUT_DIR"

for R1 in "$READ_DIR"/*_R1.trimmed.fq.gz; do
    R2="${R1/_R1./_R2.}"
    SAMPLE=$(basename "$R1" _R1.trimmed.fq.gz)

    if [[ -f "$R1" && -f "$R2" ]]; then
        echo "▶ Processing sample: $SAMPLE"

        LOG="$OUT_DIR/${SAMPLE}_bowtie2.log"

        bowtie2 -x "$HOST_INDEX" \
            -1 "$R1" -2 "$R2" \
            --very-sensitive \
            -S /dev/null \
            --un-conc-gz "$OUT_DIR/${SAMPLE}_filtered.fq.gz" \
            --threads 32 > "$LOG" 2>&1

        # Rename for clarity
        mv "$OUT_DIR/${SAMPLE}_filtered.fq.1.gz" "$OUT_DIR/${SAMPLE}_R1.filtered.fq.gz"
        mv "$OUT_DIR/${SAMPLE}_filtered.fq.2.gz" "$OUT_DIR/${SAMPLE}_R2.filtered.fq.gz"

        echo "✅ Done: $SAMPLE"
    else
        echo "⚠️  Missing files for $SAMPLE — Skipping"
    fi
done

echo "🎉 All done!"
