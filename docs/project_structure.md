# Kvass Project Directory Structure

## Sample Mapping

- **AA** — Sourdough Starter X (SDX)
- **B1** — Sourdough Starter Y (SDY)
- **C1** — Low-Sugar ginger kvass with fibre, fermented with SDX (LSGF-Kvass-X)
- **D1** — Standard kvass, fermented with SDX (Std-Kvass-X)
- **E1** — Low-Sugar kvass with fibre, fermented with SDX (LSF-Kvass-X)
- **F1** — Low-Sugar kvass with fibre, fermented with SDY (LSF-Kvass-Y)

## Project Directory Layout

Kvass_project/
├── data/
│   ├── raw/
│   │   └── shotgun/
│   │       ├── *_1.fq.gz → Raw forward shotgun reads (R1) for each sample
│   │       └── *_2.fq.gz → Raw reverse shotgun reads (R2) for each sample
│   ├── processed/
│   │   ├── trimmed_reads/
│   │   │   ├── *_R1.trimmed.fq.gz → R1 reads after quality trimming (fastp)
│   │   │   └── *_R2.trimmed.fq.gz → R2 reads after quality trimming (fastp)
│   │   └── host_filtered_reads/
│   │       ├── *_R1.filtered.fq.gz → R1 reads after removing host-mapped reads (Bowtie2)
│   │       ├── *_R2.filtered.fq.gz → R2 reads after removing host-mapped reads (Bowtie2)
│   │       └── *_bowtie2.log → Logs of Bowtie2 mapping for host filtering
├── genomes/
│   ├── *.fa → Individual host genomes (plants + human) in FASTA format
│   │   ├── Cichorium_intybus.fa
│   │   ├── Hordeum_vulgare.MorexV3_pseudomolecules_assembly.dna.toplevel.fa
│   │   ├── Secale_cereale_Rye_Lo7.fa
│   │   ├── Zingiber_officinale.fa
│   │   └── Homo_sapiens.GRCh38.dna.primary_assembly.fa
│   ├── combined_hosts.fa → Concatenated FASTA file of all host genomes
│   └── combined_hosts.*.bt2l → Bowtie2 index files generated from combined_hosts.fa
├── results/
│   ├── fastp/
│   │   ├── *.html → fastp interactive HTML reports (per sample)
│   │   └── *.json → fastp output in JSON format with trimming stats
│   ├── fastqc_trimmed/
│   │   ├── *.html → Quality reports from FastQC on trimmed reads
│   │   └── *.zip → Compressed FastQC data for further inspection
│   ├── multiqc/
│   │   ├── multiqc_report.html → Combined QC summary for raw data
│   │   └── multiqc_data/ → Supporting files for the above MultiQC report
│   └── multiqc_trimmed/
│       ├── multiqc_report.html → Combined QC summary for trimmed data
│       └── multiqc_data/ → Supporting files for trimmed MultiQC summary
├── scripts/
│   └── run_host_filtering.sh → Bash script to filter host reads using Bowtie2

