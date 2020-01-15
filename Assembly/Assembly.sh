#!/bin/bash

#SBATCH -c 64
#SBATCH -p long
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de

# here starts your actual program call/computation
#
#echo "START TIME: " `date`

for R1 in *.fasta
    do
        echo $R1
        #R2=`echo $R1 | sed 's/_R1_/_R2_/'`
        #bname=`echo $R1 | sed 's/_R1_.\+//'`
	N=$(basename $R1 .fasta | sed 's/_R1_.\+//' )
	#megahit -r $R1 -o $N 
	idba_ud -r $R1 -o $N
	#cp -r $bname result  

#megahit -1 pe_1.fq.gz -2 pe_2.fq.gz -o megahit_out

done

