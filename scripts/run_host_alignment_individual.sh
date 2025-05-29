#!/bin/bash
set -euo pipefail

# === Directories ===
READ_DIR=~/Kvass_project/data/processed/trimmed_reads
INDEX_DIR=~/Kvass_project/individual_host
OUT_DIR=~/Kvass_project/results/host_alignment_stats
mkdir -p "$OUT_DIR"

# === Host genome index prefixes (already built) ===
declare -A HOSTS=(
    [human]="$INDEX_DIR/human"
    [barley]="$INDEX_DIR/barley"
    [rye]="$INDEX_DIR/rye"
    [chicory]="$INDEX_DIR/chicory"
    [ginger]="$INDEX_DIR/ginger"
)

# === Loop through each sample ===
for R1 in "$READ_DIR"/*_R1.trimmed.fq.gz; do
    SAMPLE=$(basename "$R1" _R1.trimmed.fq.gz)
    R2="$READ_DIR/${SAMPLE}_R2.trimmed.fq.gz"

    if [[ ! -f "$R2" ]]; then
        echo "⚠️ Missing R2 for $SAMPLE. Skipping."
        continue
    fi

    # Check if all alignment log files exist for this sample
    all_logs_exist=true
    for host in "${!HOSTS[@]}"; do
	LOG="${OUT_DIR}/${SAMPLE}_${host}_bowtie2.log"
	if [[ ! -f "$LOG" ]]; then
          all_logs_exist=false
          break
	fi
    done

if $all_logs_exist; then
    echo "✅ All alignments exist for $SAMPLE, skipping."
    continue
fi

    for host in "${!HOSTS[@]}"; do
        INDEX_PREFIX="${HOSTS[$host]}"
        LOG="${OUT_DIR}/${SAMPLE}_${host}_bowtie2.log"

        echo "🔍 Aligning $SAMPLE to $host..."
        bowtie2 -x "$INDEX_PREFIX" \
            -1 "$R1" -2 "$R2" \
            --very-sensitive \
            -S /dev/null \
            --threads 64 > "$LOG" 2>&1
    done

    echo "✅ Done: $SAMPLE"
done

echo "🎉 All samples aligned to individual host genomes."

