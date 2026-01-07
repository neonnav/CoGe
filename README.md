# CoGe-Pipeline

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Bash](https://img.shields.io/badge/Language-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Conda](https://img.shields.io/badge/Platform-Conda-blue.svg)](https://docs.conda.io/)
[![Pipeline](https://img.shields.io/badge/Type-Bioinformatics%20Pipeline-orange.svg)]()

**Automated Bacterial Genome Annotation & BGC Discovery Pipeline**

---

## Overview

**CoGe-Pipeline** is an end-to-end, automated bioinformatics pipeline developed for large-scale bacterial genome analysis and secondary metabolite discovery. It was designed as part of the **One Day One Genome (ODOG)** initiative to process 25–30 bacterial genomes in a reproducible, scalable, and fault-tolerant manner.

The pipeline takes paired-end Illumina reads as input and produces:
- High-quality genome assemblies
- Functional annotations
- Biosynthetic gene cluster (BGC) predictions
- Comparative BGC clustering results

---

## Pipeline Workflow

```
Paired-end FASTQ
   ├── FastQC (raw QC)
   ├── fastp (trimming & filtering)
   ├── FastQC (post-trim QC)
   ├── SPAdes (genome assembly)
   ├── QUAST (assembly quality)
   ├── Prokka (genome annotation)
   ├── antiSMASH (BGC prediction)
   └── BiG-SCAPE (comparative BGC clustering)
```

---

## Key Features

- **Fully automated** end-to-end workflow  
- **Handles multiple genomes** in a single run  
- **Robust error handling** (failed genomes are skipped, pipeline continues)  
- **Resume-friendly**: completed steps are not recomputed  
- **Conda-based reproducible environments**  
- **Supports comparative BGC analysis** across all genomes  
- **Generates interactive BiG-SCAPE HTML visualizations**

---

## Tools

| Tool | Purpose | Citation |
|------|---------|----------|
| [**FastQC**](https://www.bioinformatics.babraham.ac.uk/projects/fastqc/) | Read quality control | Andrews S. (2010). FastQC: A Quality Control Tool for High Throughput Sequence Data |
| [**fastp**](https://github.com/OpenGene/fastp) | Read trimming & filtering | Chen et al. (2018). *Bioinformatics*, 34(17):i884-i890. [DOI:10.1093/bioinformatics/bty560](https://doi.org/10.1093/bioinformatics/bty560) |
| [**SPAdes**](https://github.com/ablab/spades) | De novo genome assembly | Bankevich et al. (2012). *J Comput Biol*, 19(5):455-477. [DOI:10.1089/cmb.2012.0021](https://doi.org/10.1089/cmb.2012.0021) |
| [**QUAST**](https://github.com/ablab/quast) | Assembly quality assessment | Gurevich et al. (2013). *Bioinformatics*, 29(8):1072-1075. [DOI:10.1093/bioinformatics/btt086](https://doi.org/10.1093/bioinformatics/btt086) |
| [**Prokka**](https://github.com/tseemann/prokka) | Genome annotation | Seemann T. (2014). *Bioinformatics*, 30(14):2068-2069. [DOI:10.1093/bioinformatics/btu153](https://doi.org/10.1093/bioinformatics/btu153) |
| [**antiSMASH**](https://antismash.secondarymetabolites.org/) | Biosynthetic gene cluster detection | Blin et al. (2023). *Nucleic Acids Res*, 51(W1):W46-W50. [DOI:10.1093/nar/gkad344](https://doi.org/10.1093/nar/gkad344) |
| [**BiG-SCAPE**](https://github.com/medema-group/BiG-SCAPE) | BGC clustering & network analysis | Navarro-Muñoz et al. (2020). *Nat Chem Biol*, 16:60-68. [DOI:10.1038/s41589-019-0400-9](https://doi.org/10.1038/s41589-019-0400-9) |


---

## Input Requirements

**Paired-end Illumina FASTQ files:**
```
sample_R1.fastq.gz
sample_R2.fastq.gz
```

⚠️ **Important**: Sample names must **NOT** contain spaces or special characters.

---

## Output Structure

```
results/
 ├── sample1/
 │   ├── fastqc_raw/
 │   ├── fastp_output/
 │   ├── spades_output/
 │   ├── quast_output/
 │   ├── prokka_output/
 │   └── antismash_output/
 ├── bigscape_output/
 │   ├── index.html
 │   ├── network files
 │   └── GCF results
 └── logs/
```

---

## Installation

A dedicated installation script is provided to:
- Detect or install Conda automatically
- Create required Conda environments
- Install all dependencies (antiSMASH DBs, Pfam, BiG-SCAPE requirements)

```bash
bash install.sh
```

---

## Running the Pipeline

Run the pipeline from the directory containing FASTQ files:

```bash
bash genome_pipeline.sh
```

**BiG-SCAPE** is executed once after all genomes are processed, enabling comparative analysis across the full dataset.

---

## Results Interpretation

- **antiSMASH outputs** identify BGCs per genome
- **BiG-SCAPE outputs** cluster BGCs into Gene Cluster Families (GCFs)
- **Interactive visualization** available via:
  ```
  results/bigscape_output/index.html
  ```

---

## Applications

- Comparative bacterial genomics
- Natural product & secondary metabolite discovery
- Antibiotic and bioactive compound mining
- Functional genomics research
- Large-scale genome annotation projects

---

## Future Scope

- AI-based BGC novelty prediction
- Bioactivity prediction models
- Automated genome & BGC summary reports
- Integration with metabolomics (LC-MS/MS)

---

## Citation

If you use CoGe-Pipeline in your research, please cite:

```
CoGe-Pipeline: Automated Bacterial Genome Annotation & BGC Discovery Pipeline
One Day One Genome (ODOG) Initiative
Bharat Genome Database (BGDB)
2025. Available at: [GitHub URL]
```

**Additionally, please cite all the tools used in the pipeline** (see Tools table above).

---

## Author

Developed as part of the **One Day One Genome (ODOG)** project  
Maintained by **Bharat Genome Database (BGDB)** contributors

---

## License

This project is released under the [MIT License](https://opensource.org/licenses/MIT).

---

## Support

For issues, questions, or contributions, please open an issue on GitHub or contact the BGDB team.

---

**⭐ If you find this pipeline useful, please consider starring the repository!**