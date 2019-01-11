#Read the file and make a subdata
data_nmds <- read.csv(file.choose())
rm(list = setdiff(ls(), lsf.str()))
data_nmds <- read.csv("kaiju_table_bacteria_genus_modified_rm_untreated.csv", header = TRUE, sep = "\t")
head(data_nmds,2)
dim(data_nmds)
data_nmds$Samples
data_nmds$Treatments
data_sub <-data_nmds[4:426]
data_sub
dim(data_sub)
########################################
#Calculation of MDS and ploting the points
library(vegan)
library(plyr)
bac_community.mds <- metaMDS(comm = data_sub, distance = "bray", trace = TRUE,autotransform = FALSE)
#bac_community.mds <- prcomp(comm = data_sub)
plot(bac_community.mds$points) 
MDS_xy <- data.frame(bac_community.mds$points)
MDS_xy$Samples <- data_nmds$Samples
MDS_xy$Treatments <-data_nmds$Treatments
MDS_xy$Replicates <- data_nmds$Replicates
###########################################
#plot data without polygon
library(ggplot2)
ggplot(MDS_xy, aes(MDS1, MDS2,  color = Treatments, frame = TRUE, frame.type = 'norm', label.size = 3)) + geom_point() + theme_bw() +
  geom_point(aes(shape = Samples), size = 5) + xlab("NMDS1") + ylab("NMDS2") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank())
#######################################

#plot the picture and save it as an object which is needed to draw the polygon
plot_nmds <- ggplot(MDS_xy, aes(MDS1, MDS2, color = Treatments, frame = TRUE, frame.type = 'norm' )) + geom_point() + theme_bw() +
  geom_point(aes(shape = Samples), size = 4) + xlab("NMDS1") + ylab("NMDS2") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank())

#Extract information for the polygons from the information of the picture
df <- plot_nmds$data
find_hull <- function(df) df[chull(df$MDS1, df$MDS2), ] #MDS1 is the first dimension info and MDS2 is the second dimension information.
hulls <- ddply(df, "Treatments", find_hull) #"Treatment" is the information for the group.

#plot the picture again
svg(filename="Std_SVG.svg")
    ggplot(MDS_xy, aes(MDS1, MDS2, color = Treatments, frame = TRUE, frame.type = 'norm' )) + geom_point() + theme_bw() +
  geom_point(aes(shape = Samples), size = 4) + xlab("NMDS1") + ylab("NMDS2") +
  theme(panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        plot.background = element_blank())+
  geom_polygon(data = hulls, alpha = 0.5, aes(fill=Treatments), show.legend= FALSE)
    
    
  p<-  ggplot(MDS_xy, aes(MDS1, MDS2, color = Treatments, frame = TRUE, frame.type = 'norm' )) + geom_point() + theme_bw() +
      geom_point(aes(shape = Samples), size = 4) + xlab("NMDS1") + ylab("NMDS2") +
      theme(panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            plot.background = element_blank())+
      geom_polygon(data = hulls, alpha = 0.5, aes(fill=Treatments), show.legend= FALSE)
    
  p + theme(
    plot.title = element_text(color="red", size=14, face="bold.italic"),
    axis.title.x = element_text(color="blue", size=14, face="bold"),
    axis.title.y = element_text(color="#993333", size=14, face="bold")
  )
