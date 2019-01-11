#!/bin/bash
#SBATCH -c 8
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de
#SBATCH --job-name=fastq2kaiju
echo "START TIME: " `date`
for i in *.fastq # Change ONLY if different split FASTQ files folder name
do
kaiju -z 8 -t /home/project/Database/kaijudb/nodes.dmp -f /home/project/Database/kaijudb/kaiju_db_nr_euk.fmi -i $i -o $(basename "$i" .fastq)_kaiju.out 
done
echo "END TIME: " `date`
