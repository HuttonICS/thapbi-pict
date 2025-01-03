#!/bin/bash

#The following will be used on SLURM via sbatch:
#======================================================
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=150M
#SBATCH --time=0:10:00
#SBATCH --job-name=drained_ponds
#======================================================

set -euo pipefail

echo NOTE: Expected first time run time is under 5 minutes,
echo repeat runs take seconds just to regenerate reports
echo

if [ ! -f NCBI_12S.sqlite ]; then
    echo "Building 12S database from NCBI sequences"
    thapbi_pict import -d NCBI_12S.sqlite -i NCBI_12S.fasta -x -s ";" \
        -k 12S --left ACTGGGATTAGATACCCC --right TAGAACAGGCTCCTCTAG \
        --minlen 80 --maxlen 130
fi

# Primers, quoting Muri et al:
#
#    In the first round of PCR, indexed primers targeting a 106 bp
#    region within the mitochondrial 12S gene were used (Riaz et al.
#    2011; Kelly et al. 2014).
#
# Quoting Kelly et al. 2014:
#
#    We amplified target samples using PCR primers designed by Riaz and
#    coauthors to amplify vertebrate-specific fragments from the
#    mitochondrial 12S rRNA gene (Riaz et al. 2011). A 106 bp fragment
#    from a variable region of the 12S rRNA gene was amplified with the
#    primers F1 (5′-ACTGGGATTAGATACCCC-3′) and R1 (5′- TAGAACAGGCTCCTCTAG-3′).

echo "Running the pipeline"
mkdir -p intermediate/ summary/
# Fraction 0.001 means 0.1%
thapbi_pict pipeline -i raw_data/ expected/ -s intermediate/ \
    -o summary/drained_ponds --synthetic '' -a 50 -f 0.001 -d NCBI_12S.sqlite \
    -t metadata.tsv -x 1 -c 5,6,7,8,9,10,4,2,3

echo "Done"
