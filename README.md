# Kvass Microbiome Project

## Overview

This project investigates the microbial diversity and functional potential of **sourdough-fermented kvass** formulations enriched with dietary fibre and botanicals. Conducted in collaboration with **Quas Drinks**, this study applies both **shotgun metagenomics** and **16S rRNA amplicon sequencing** to understand how different fermentation inputs shape microbial communities.

The research aims to create a **synbiotic** kvass—combining **probiotics** from sourdough fermentation with **prebiotic** ingredients (inulin and ginger)—to support gut health through targeted microbiome modulation.

## Objectives

Hypothesis 1:
Sourdough Starters X and Y have significantly different microbial communities and functional gene profiles prior to fermentation.

Hypothesis 2:
Fermentation of kvass with a sourdough starter causes a major shift in microbial diversity and function compared to the original starter culture.

Hypothesis 3:
Using low-sugar and fibre (inulin) in kvass selectively enriches microbes and genes adapted to these substrates compared to standard kvass.

Hypothesis 4:
Even under the same fermentation conditions, different sourdough starters imprint distinct microbial and functional signatures on the final kvass.

Hypothesis 5:
Adding ginger to kvass alters the microbial community structure and functions due to the selective pressure of ginger’s bioactive compounds.

Hypothesis 6:
Different kvass formulations and starter cultures lead to distinct functional potentials related to fibre degradation, SCFA production, and other health-relevant pathways.
## Sample Summary

| Sample | Description                                                   |
|--------|---------------------------------------------------------------|
| AA     | Sourdough Starter X (SDX)                                     |
| B1     | Sourdough Starter Y (SDY)                                     |
| C1     | Low-Sugar Ginger Kvass with fibre, fermented with Starter X   |
| D1     | Standard Kvass, fermented with Starter X                      |
| E1     | Low-Sugar Kvass with fibre, fermented with Starter X          |
| F1     | Low-Sugar Kvass with fibre, fermented with Starter Y          |

## Methods

- **DNA Extraction**: Qiagen PowerSoil Pro Kit
- **Sequencing Platforms**:
  - **16S rRNA** (V3–V4): Illumina PE250 (~30,000 reads/sample)
  - **Shotgun Metagenomics**: NovaSeq X (2×150 bp, ~6 Gb/sample)
- **Taxonomic Profiling**:
  - 16S: QIIME 2 + DADA2 + SILVA
  - Shotgun: MetaPhlAn3
- **Functional Profiling**:
  - Shotgun: HUMAnN3 (UniRef90 + MetaCyc)
- **Statistical Analysis**:
  - Alpha/beta diversity
  - Differential abundance (ANCOM, DESeq2, LEfSe)
  - PCA, heatmaps, and pathway enrichment

## Host Contaminant Filtering

Shotgun reads are filtered using Bowtie2 to remove eukaryotic contaminants:
- **Rye**: *Secale cereale*
- **Barley**: *Hordeum vulgare*
- **Ginger**: *Zingiber officinale*
- **Human**: *Homo sapiens*
- **Yeast**: *Saccharomyces cerevisiae*

## Data Output

The project will generate:
- Annotated 16S and shotgun sequencing data
- ASV tables, taxonomic barplots
- Functional gene/pathway abundance profiles
- MultiQC summary reports
- Visualisations (PCA, heatmaps)
- Scripts for reproducibility

## Dependencies and Tools

- QIIME 2
- MetaPhlAn3
- HUMAnN3
- Fastp / Trimmomatic
- Bowtie2
- MultiQC
- Python (pandas, seaborn)
- R (phyloseq, vegan)

## Project Status

✅ Raw and processed FASTQ files  
✅ Host-filtered reads  
✅ fastp, FastQC, MultiQC reports  
🔜 Shotgun functional profiling (HUMAnN3)  
🔜 Visualisation and interpretation

## Acknowledgements

This project is conducted under the MSc Bioinformatics program at the University of Edinburgh (2024–2025) and is supervised by **Anton Puzorjov** and **Dr. Alasdair Ivens**.

Special thanks to **Quas Drinks** for sample provision and technical collaboration.

---

