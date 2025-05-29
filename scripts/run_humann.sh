#!/bin/bash
set -euo pipefail

# Directories
INPUT_DIR="$HOME/Kvass_project/data/processed/host_filtered_reads"
OUTPUT_DIR="$HOME/Kvass_project/results/humann3"
DB_DIR="$HOME/humann_db"       # directory to store HUMAnN3 databases

THREADS=16

# Create output and database directories if they don't exist
mkdir -p "$OUTPUT_DIR"
mkdir -p "$DB_DIR"

echo "🔍 Checking and downloading HUMAnN3 databases if missing..."

# Download databases if missing
if [ ! -d "$DB_DIR/utility_mapping" ]; then
  echo "Downloading utility mapping database..."
  humann_databases --download utility_mapping full "$DB_DIR"
fi

if [ ! -d "$DB_DIR/chocophlan" ]; then
  echo "Downloading chocophlan database..."
  humann_databases --download chocophlan full "$DB_DIR"
fi

if [ ! -d "$DB_DIR/uniref90" ]; then
  echo "Downloading uniref90 database..."
  humann_databases --download uniref90 full "$DB_DIR"
fi

echo "🔧 Configuring HUMAnN3 database locations..."
#humann_config --update database_folders nucleotide "$DB_DIR/chocophlan"
#humann_config --update database_folders protein "$DB_DIR/uniref90"
#humann_config --update database_folders utility "$DB_DIR/utility_mapping"

echo "🎯 Starting HUMAnN3 runs on filtered paired-end reads..."

for R1 in "$INPUT_DIR"/*_R1.filtered.fq.gz; do
  SAMPLE=$(basename "$R1" _R1.filtered.fq.gz)
  R2="${R1/_R1./_R2.}"

  if [[ ! -f "$R2" ]]; then
    echo "⚠️ Paired file missing for $SAMPLE, skipping"
    continue
  fi

  SAMPLE_OUT="$OUTPUT_DIR/$SAMPLE"
  mkdir -p "$SAMPLE_OUT"

  echo "▶ Running HUMAnN3 for sample: $SAMPLE"

  humann \
    --input "$R1" \
    --input "$R2" \
    --output "$SAMPLE_OUT" \
    --threads $THREADS \
    --remove-temp-output

  echo "✅ Completed HUMAnN3 for sample: $SAMPLE"
done

echo "🎉 All HUMAnN3 runs complete!"

