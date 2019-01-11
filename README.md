# Metagenome

**Useful code for metagenome analysis**

#Count number of reads in a FastQ file


`awk ‘END{print NR/4}’ file.fastq`

#Convert FastQ to FastA

`awk 'NR%4==1{a=substr($0,2);}NR%4==2{print ">"a"\n"$0}’ file.fastq`

#Convert multi-line FASTQ to 4-line FASTQ:

`seqtk seq -l0 in.fq > out.fq`

#copy file from subfolder

`find /home/ -name *_kneaddata.fastq -exec cp {} /home/merged/ \;`
