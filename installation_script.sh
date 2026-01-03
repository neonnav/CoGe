#!/usr/bin/env bash
set -euo pipefail


GENOME_ENV="genome-pipeline"
BIGSCAPE_ENV="bigscape-env"
ANTISMASH_DB_DIR="$HOME/antismash_db"
PFAM_DIR="$HOME/pfam"
PFAM="$PFAM_DIR/Pfam-A.hmm"

echo "===================================================="
echo "      Installing PIPELINE requirements"
echo "===================================================="

# STEP 1 — Install conda (if missing)

echo "Checking for conda…"

if ! command -v conda >/dev/null 2>&1; then
    echo "Conda not found — installing Miniconda…"

    mkdir -p "$HOME/miniconda3"
    wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
        -O "$HOME/miniconda3/miniconda.sh"
    bash "$HOME/miniconda3/miniconda.sh" -b -u -p "$HOME/miniconda3"
    rm "$HOME/miniconda3/miniconda.sh"
else
    echo "Conda already installed."
fi

# STEP 2 — Load conda.sh

if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/miniconda3/etc/profile.d/conda.sh"
elif [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
    source "$HOME/anaconda3/etc/profile.d/conda.sh"
else
    echo "ERROR: conda.sh not found!"
    exit 1
fi

export PATH="$HOME/miniconda3/bin:$PATH"
hash -r

# STEP 3 — Accept Conda ToS

echo "Accepting Conda TOS"
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main || true
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r || true

# STEP 4 — Create genome-pipeline environment

if conda env list | grep -q "^${GENOME_ENV}"; then
    echo "Environment '${GENOME_ENV}' already exists."
else
    echo "Creating ${GENOME_ENV}…"
    conda create -y -n "$GENOME_ENV" python=3.10
fi

conda activate "$GENOME_ENV"

# STEP 5 — Add bioconda channels

echo "Configuring conda channels…"
conda config --add channels defaults || true
conda config --add channels bioconda || true
conda config --add channels conda-forge || true

# STEP 6 — Install genome tools

echo "===================================================="
echo "     Installing genome pipeline tools"
echo "===================================================="

conda install -y fastqc fastp spades quast prokka parallel
conda install -y antismash

# STEP 7 — Install antiSMASH Databases

echo "===================================================="
echo "     Installing antiSMASH Databases"
echo "===================================================="

mkdir -p "$ANTISMASH_DB_DIR"

echo "Downloading antiSMASH database (~12-20GB)…"
download-antismash-databases --database-dir "$ANTISMASH_DB_DIR"

echo "antiSMASH DB installed: $ANTISMASH_DB_DIR"

# STEP 8 — Create BiG-SCAPE environment

echo "===================================================="
echo "     Installing BiG-SCAPE environment"
echo "===================================================="

if conda env list | grep -q "^${BIGSCAPE_ENV}"; then
    echo "'${BIGSCAPE_ENV}' already exists."
else
    conda create -y -n "$BIGSCAPE_ENV" python=3.11
fi

conda activate "$BIGSCAPE_ENV"

echo "Installing dependencies…"
pip install click biopython scipy psutil requests tqdm

echo "Installing pyhmmer…"
pip install pyhmmer

echo "Cloning BiG-SCAPE…"
if [ ! -d "$HOME/BiG-SCAPE" ]; then
    git clone https://github.com/medema-group/BiG-SCAPE.git "$HOME/BiG-SCAPE"
fi

cd "$HOME/BiG-SCAPE"
pip install .

echo "BiG-SCAPE installed."

# STEP 9 — Install Pfam-A.hmm

echo "===================================================="
echo "     Installing Pfam-A.hmm"
echo "===================================================="

mkdir -p "$PFAM_DIR"

if [[ ! -f "$PFAM" ]]; then
    echo "Downloading Pfam-A.hmm (250MB)…"
    wget -q https://ftp.ebi.ac.uk/pub/databases/Pfam/releases/Pfam35.0/Pfam-A.hmm.gz \
        -O "$PFAM_DIR/Pfam-A.hmm.gz"
    gunzip "$PFAM_DIR/Pfam-A.hmm.gz"
fi

if [[ ! -f "$PFAM.h3i" ]]; then
    echo "Indexing Pfam with hmmpress…"
    hmmpress "$PFAM"
fi

echo "Pfam installed: $PFAM"

echo "===================================================="
echo "   FULL INSTALLATION COMPLETE!"
echo "===================================================="
echo "Use these environments:"
echo "   conda activate ${GENOME_ENV}"
echo "   conda activate ${BIGSCAPE_ENV}"
echo
echo "Now you can run the main pipeline script."
echo "===================================================="
