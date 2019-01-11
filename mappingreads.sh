#!/bin/bash

#SBATCH -c 32
#SBATCH -p short
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de

# here starts your actual program call/computation
#
#echo "START TIME: " `date`
for i in *fastq
  do
      bwa mem -p /home/hig18/project/Ref_genome/Homo_sapiens_UCSC_hg38/Homo_sapiens/UCSC/hg38/Sequence/BWAIndex/genome.fa $i > ${i}.aln.sam
  done
#echo "END TIME: " `date`
