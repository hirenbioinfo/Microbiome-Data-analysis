#!/bin/bash
#SBATCH -c 32
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de
# here starts your actual program call/computation
#
echo "START TIME: " `date`
for i in *.fastq.gz # Change ONLY if different split FASTQ files folder name
do
seqkit stat $i -j 8 -T | csvtk csv2md -t > out_all
done
echo "END TIME: " `date`
