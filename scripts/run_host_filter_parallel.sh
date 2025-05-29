#!/bin/bash
set -euo pipefail

READ_DIR="$HOME/Kvass_project/data/processed/trimmed_reads"
OUT_DIR="$HOME/Kvass_project/data/processed/host_parallel_filtered_reads"
HOST_INDEX="$HOME/Kvass_project/genomes/combined_hosts"

mkdir -p "$OUT_DIR"

parallel_jobs=3
job_count=0

for R1 in "$READ_DIR"/*_R1.trimmed.fq.gz; do
  (
    R2="${R1/_R1./_R2.}"
    SAMPLE=$(basename "$R1" _R1.trimmed.fq.gz)
    LOG="$OUT_DIR/${SAMPLE}_bowtie2.log"

    echo "🔍 Processing sample: $SAMPLE"
    echo "     R1: $R1"
    echo "     R2: $R2"

    if [[ -f "$R1" && -f "$R2" ]]; then
      {
        echo "▶ Starting host filtering for: $SAMPLE"

        bowtie2 -x "$HOST_INDEX" \
          -1 "$R1" -2 "$R2" \
          --very-sensitive \
          -S /dev/null \
          --un-conc-gz "$OUT_DIR/${SAMPLE}_filtered.fq.gz" \
          --threads 16

        if [[ -f "$OUT_DIR/${SAMPLE}_filtered.fq.1.gz" && -f "$OUT_DIR/${SAMPLE}_filtered.fq.2.gz" ]]; then
          mv "$OUT_DIR/${SAMPLE}_filtered.fq.1.gz" "$OUT_DIR/${SAMPLE}_R1.filtered.fq.gz"
          mv "$OUT_DIR/${SAMPLE}_filtered.fq.2.gz" "$OUT_DIR/${SAMPLE}_R2.filtered.fq.gz"
          echo "✅ Completed filtering for: $SAMPLE"
        else
          echo "⚠️ Output files missing for $SAMPLE — skipping rename." >&2
        fi

      } > "$LOG" 2>&1
    else
      echo "⚠️ Missing R1 or R2 files for $SAMPLE — skipping" > "$LOG"
    fi
  ) &

  ((job_count++))
  if (( job_count % parallel_jobs == 0 )); then
    wait
  fi
done

wait
echo "🎉 All host filtering complete!"

