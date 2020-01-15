### For binning there are n numbers of alternate way. Here one example of Metabat alternatetively one cam use maxbin as well.


qsub -cwd -pe multislot 12 -N metabat -l mtc=1 -b y \ /vol/cmg/bin/runMetaBat.sh final.contigs.fa megahit_sorted.bam
