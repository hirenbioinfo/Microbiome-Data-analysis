
#SBATCH -c 32
#SBATCH -p short
#SBATCH --mail-type=END
#SBATCH --mail-user=hig18@dsmz.de

# here starts your actual program call/computation
#

for i in *fasta
do
	N=$(basename $i .fasta) ; 
	blastn -max_target_seqs 1 -db /home/scratch/databases/blast/nt_20161019/nt -query $i -num_threads 28 -outfmt '6 qseqid stitle pident length evalue staxids' -out $N.txt
done
