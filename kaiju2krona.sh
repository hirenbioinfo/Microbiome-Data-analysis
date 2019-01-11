#!/bin/bash

#SBATCH -c 32
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=XXXX@dsmz.de

# here starts your actual program call/computation
#filtering mapped & unmapped reads
#Merged all the forward and reverse fastq file and run the script to get 

for i in *.out # Change ONLY if different split FASTQ files folder name
do
#kaiju -z 25 -t /home/hig18/project/Database/kaijudb/nodes.dmp -f /home/hig18/project/Database/kaijudb/kaiju_db_nr_euk.fmi -i $i -e 5 -o $(basename "$i"kaiju.out .fastq) 
kaiju2krona -t /home/hig18/project/Database/kaijudb/nodes.dmp -n /home/hig18/project/Database/kaijudb/names.dmp -i $i -o $(basename "$i" .out).kaiju.krona.out
#ktImportText -o $(basename "$i" .fastq).kaiju.out.krona.html $(basename "$i" .fastq).kaiju.out.krona
done


