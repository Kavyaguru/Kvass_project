# 🧪 Daily Log — Kvass Project

A daily record of progress, tools used, and relevant commands.

---

## 📅 Day 1 - 21-05-2025
**Tasks Completed:**
- Downloaded raw sequencing data
- Ran initial quality check using `FastQC` and `MultiQC`

---

## 📅 Day 2 - 22-05-2025
**Tasks Completed:**
- Trimmed raw reads using `fastp`
- Ran `FastQC` on trimmed reads
- Summarized quality reports using `MultiQC`

---

## 📅 Day 3 - 23-05-2025
**Tasks Completed:**
- Downloaded host genomes:
  - Ginger (*Zingiber officinale*)
  - Rye (*Secale cereale*)
  - Barley (*Hordeum vulgare*)
  - Chicory (*Cichorium intybus*)
  - Human (*Homo sapiens*)
- Built the combined host genome FASTA
- Created Bowtie2 index from `combined_hosts.fa`

---

## 📅 Day 4 - 26-05-2025
**Tasks Completed:**
- Removed host DNA from kvass samples using `Bowtie2`
  - Used combined index (ginger, barley, rye, chicory, human)
  - Retained only unaligned (microbial) reads
## 📅 Day 5 - 27-05-2025
**Tasks Completed:**
- Ran host filtering individually for each host genome using `Bowtie2`
  - Aligned reads separately to barley, chicory, ginger, rye, and human
  - Compared alignment rates to assess host-specific contamination

---

## 📅 Day 6 - 28-05-2025
**Tasks Completed:**
- Created new Conda environment: `metaphlan-env`
- Installed `MetaPhlAn` from Bioconda
- Ran `MetaPhlAn` on all host-filtered kvass samples for taxonomic profiling

---

## 📅 Day 7 - 29-05-2025
**Tasks Completed:**
- Created combined environment: `humann-metaphlan-env`
- Installed both `MetaPhlAn` and `HUMAnN`
- Ran `HUMAnN` on all kvass samples using MetaPhlAn profiles for functional analysis


