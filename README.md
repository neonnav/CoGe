CoGe-Pipeline

Automated Bacterial Genome Annotation & BGC Discovery Pipeline

Overview

CoGe-Pipeline is an end-to-end, automated bioinformatics pipeline developed for large-scale bacterial genome analysis and secondary metabolite discovery.
It was designed as part of the One Day One Genome (ODOG) initiative to process 25–30 bacterial genomes in a reproducible, scalable, and fault-tolerant manner.

The pipeline takes paired-end Illumina reads as input and produces high-quality genome assemblies, functional annotations, biosynthetic gene cluster (BGC) predictions, and comparative BGC clustering results.

Pipeline Workflow

Paired-end FASTQ
   ├── FastQC (raw QC)
   ├── fastp (trimming & filtering)
   ├── FastQC (post-trim QC)
   ├── SPAdes (genome assembly)
   ├── QUAST (assembly quality)
   ├── Prokka (genome annotation)
   ├── antiSMASH (BGC prediction)
   └── BiG-SCAPE (comparative BGC clustering)

Key Features

Fully automated end-to-end workflow

Handles multiple genomes in a single run

Robust error handling (failed genomes are skipped, pipeline continues)

Resume-friendly: completed steps are not recomputed

Conda-based reproducible environments

Supports comparative BGC analysis across all genomes

Generates interactive BiG-SCAPE HTML visualizations

Tools & Technologies

FastQC – Read quality control

fastp – Read trimming & filtering

SPAdes – De novo genome assembly

QUAST – Assembly quality assessment

Prokka – Genome annotation

antiSMASH – Biosynthetic gene cluster detection

BiG-SCAPE – BGC clustering & network analysis

Pfam / HMMER – Domain analysis

Bash & Conda – Pipeline automation & reproducibility

Input Requirements

Paired-end Illumina FASTQ files
sample_R1.fastq.gz
sample_R2.fastq.gz
⚠️ Important: Sample names must NOT contain spaces or special characters.

Output Structure
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

Installation

A dedicated installation script is provided to:

Detect or install Conda automatically

Create required Conda environments

Install all dependencies (antiSMASH DBs, Pfam, BiG-SCAPE requirements)

bash install.sh

Running the Pipeline

Run the pipeline from the directory containing FASTQ files:
bash genome_pipeline.sh
BiG-SCAPE is executed once after all genomes are processed, enabling comparative analysis across the full dataset.

Results Interpretation

antiSMASH outputs identify BGCs per genome

BiG-SCAPE outputs cluster BGCs into Gene Cluster Families (GCFs)

Interactive visualization available via:
results/bigscape_output/index.html

Applications

Comparative bacterial genomics

Natural product & secondary metabolite discovery

Antibiotic and bioactive compound mining

Functional genomics research

Large-scale genome annotation projects

Future Scope

AI-based BGC novelty prediction

Bioactivity prediction models

Automated genome & BGC summary reports

Integration with metabolomics (LC-MS/MS)

Author

Developed as part of the One Day One Genome (ODOG) project
Maintained by Bharat Genome Database (BGDB) contributors

License

This project is released under the MIT License (or update as needed).
