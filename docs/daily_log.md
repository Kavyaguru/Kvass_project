# 🧪 Daily Log — Kvass Project

A daily record of progress, tools used, and relevant commands.

---

## 📅 Day 1
**Tasks Completed:**
- Downloaded raw sequencing data
- Ran initial quality check using `FastQC` and `MultiQC`

---

## 📅 Day 2
**Tasks Completed:**
- Trimmed raw reads using `fastp`
- Ran `FastQC` on trimmed reads
- Summarized quality reports using `MultiQC`

---

## 📅 Day 3
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

## 📅 Day 4
**Tasks Completed:**
- Removed host DNA from kvass samples using `Bowtie2`
  - Used combined index (ginger, barley, rye, chicory, human)
  - Retained only unaligned (microbial) reads


