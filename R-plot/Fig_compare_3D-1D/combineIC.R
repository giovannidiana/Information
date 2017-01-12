require(abind);

Print3DInfos <- function(GTtest){
#pdf(paste(GTtest,"_all.pdf",sep=""));
# Label of food to be used
foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);
# select genotype
# GTtest="QL435"
# Extract informations from file:
# The format of the input file is
# row 1: information broken down by food for the joint 3D distribution + total mutual 
#        information (Channel capacity because it is the optimized one)
# row 2-4 Mutual information between food and single neurons obtained from the intput_prob
#         optimized for the 3D data. Information per food level + total
# 
tabInfo <- read.table(file=paste(GTtest,"_all.dat",sep=""),header=F);
# Combine the redundancy to tabInfo
tabInfo <- rbind(tabInfo,apply(tabInfo[2:4,],2,sum)-tabInfo[1,])

# Load the groups 1 to 5 to calculate the uncertainty
tabInfo_groups <- vector("list",length=5);
for( i in 1:5) {
	tabInfo_groups[[i]] <- read.table(file=paste(GTtest,"_all_group",i,".dat",sep=""),header=F); 
	tabInfo_groups[[i]] <- rbind(tabInfo_groups[[i]],apply(tabInfo_groups[[i]][2:4,],2,sum)-tabInfo_groups[[i]][1,]);
}
ab <- abind(tabInfo_groups,along=3);
tabInfo_var <- apply(ab,1:2,sd);

# Set main title:
if(GTtest=="QL196") mt="WT";
if(GTtest=="QL402") mt="daf-7(-)";
if(GTtest=="QL404") mt="tph-1(-)";
if(GTtest=="QL435") mt="tph-1(-);daf-7(-)";

layout(matrix(c(1,2),ncol=1),heights=c(3.5,1));
par(mar=c(7,5,2,2))
pos<-barplot(as.matrix(tabInfo),beside=T,cex.axis=2,ylim=c(0,1.3),
		ylab="Information (bits)",xaxt="n",cex.lab=2,
		main=mt,cex.main=2,
		col=c("blue","orange","red","yellow","purple"));
arrows(pos,as.matrix(tabInfo)-tabInfo_var,pos,as.matrix(tabInfo)+tabInfo_var, length=0.05,angle=90,code=3,xpd=T);
text(pos[3,]-.5,par("usr")[3], labels = c(foodlist,expression("All food")), srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);

par(mar=c(2,5,0,2))
plot.new();
legend("right",legend=c("Channel capacity","Redundancy"),fill=c("blue","purple"),cex=1);
legend("left",legend=c("ADF","ASI","NSM"),fill=c("orange","red","yellow"),cex=1);
#dev.off()
}
