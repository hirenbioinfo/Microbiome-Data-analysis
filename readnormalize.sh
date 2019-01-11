####################
#here we need to normalized all the raw reads according to lowest number of reads in a particular file

seqtk sample -s100 read1.fq 10000 > sub1.fq
seqtk sample -s100 read2.fq 10000 > sub2.fq
