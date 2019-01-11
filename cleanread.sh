#!/bin/bash
#SBATCH -c 8
#SBATCH -p long
#SBATCH --job-name=kneaddata_V47
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de
# here starts your actual program call/computation
echo "Running knedata..."
echo "START TIME: " `date`
for i in *.fastq.gz # Change ONLY if different split FASTQ files folder name
do
kneaddata -i $i -o $(basename "$i" .fastq.gz) --trimmomatic /home/biotool/Trimmomatic-0.38 -t 8 --trimmomatic-options "SLIDINGWINDOW:4:20 MINLEN:36" \
-db /home/project/Database/human_genome/Homo_sapiens --bowtie2-options "--very-sensitive --dovetail" --remove-intermediate-output
done
echo "END TIME: " `date`
