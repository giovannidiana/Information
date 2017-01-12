require(abind);

#Print3DInfos <- function(GTtest){
pdf(paste("Fig3",GTtest,".pdf",sep=""),width=4,height=12);
#X11(width=4,height=12);
# Label of food to be used
foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);
# select genotype
 GTtest="QL196"
# Extract informations from file:
# The format of the input file is
# row 1: information broken down by food for the joint 3D distribution + total mutual 
#        information (Channel capacity because it is the optimized one)
# row 2-4 Mutual information between food and single neurons obtained from the intput_prob
#         optimized for the 3D data. Information per food level + total
# 
tabInfo <- read.table(file=paste(GTtest,"_all.dat",sep=""),header=F);
# Combine the redundancy to tabInfo
tabInfo <- rbind(tabInfo,apply(tabInfo[2:4,],2,sum)-tabInfo[1,7])

tabNC <- read.table(file=paste("nc_",GTtest,".dat",sep=""),header=F);
tabNC_mean <- apply(as.matrix(tabNC),2,mean)[1:6];
tabNC_var <- apply(as.matrix(tabNC),2,sd)[1:6];

tabSC <- read.table(file=paste("sc_",GTtest,".dat",sep=""),header=F);
tabSC_mean <- apply(as.matrix(tabSC),2,mean)[1:6];
tabSC_var <- apply(as.matrix(tabSC),2,sd)[1:6];

# Load the groups 1 to 5 to calculate the uncertainty
tabInfo_groups <- vector("list",length=5);
for( i in 1:5) {
	tabInfo_groups[[i]] <- read.table(file=paste(GTtest,"_all_group",i,".dat",sep=""),header=F); 
	tabInfo_groups[[i]] <- rbind(tabInfo_groups[[i]],apply(tabInfo_groups[[i]][2:4,],2,sum)-tabInfo_groups[[i]][1,]);
}
ab <- abind(tabInfo_groups,along=3);
tabInfo_var <- apply(ab,1:2,sd);

tab1<-tabInfo[2:4,1:6];
tab1_var<-tabInfo_var[2:4,1:6];

# Set main title:
if(GTtest=="QL196") mt="WT";
if(GTtest=="QL402") mt="daf-7(-)";
if(GTtest=="QL404") mt="tph-1(-)";
if(GTtest=="QL435") mt="tph-1(-);daf-7(-)";

layout(matrix(c(1,2,3,4,5,6),ncol=1),heights=c(2.,1.,1.,2.,2.,0.8));
par(mar=c(2,5,2,2))
pos<-barplot(as.matrix(tab1),cex.axis=2,ylim=c(0,1.3),
		ylab="Information (bits)",xaxt="n",cex.lab=2,
		main=mt,cex.main=2,
		col=c("orange","red","yellow"));
posmat<-matrix(rep(pos,3),ncol=6,byrow=T);
arrows(posmat,apply(as.matrix(tab1),2,cumsum)-tab1_var,posmat,apply(as.matrix(tab1),2,cumsum)+tab1_var, length=0.,angle=90,code=3,xpd=T);
lines(seq(pos[1]-0.6,pos[6]+0.6,length=10),rep(tabInfo[1,7],10),lwd=2,lty=2);

par(mar=c(0,5,2,2));
tab1pos=tabInfo;
tab1pos[tabInfo<0]<-NA;
tab1neg=-tabInfo;
tab1neg[tabInfo>0]<-NA;

tab1pos_var=tabInfo_var;
tab1pos_var[tabInfo<0]<-NA;
tab1neg_var=tabInfo_var;
tab1neg_var[tabInfo>0]<-NA;

pos<-barplot(as.numeric(tab1pos[5,1:6]),cex.axis=2,ylim=c(0,.6),
               ylab="Redundancy",xaxt="n",cex.lab=2,
	       cex.main=2, col="red",xpd=T);
arrows(pos,as.numeric(tab1pos[5,1:6]-tab1pos_var[5,1:6]),pos,as.numeric(tab1pos[5,1:6]+tab1pos_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);
par(mar=c(2,5,0,2));
pos<-barplot(as.numeric(tab1neg[5,1:6]),cex.axis=2,ylim=c(.6,0),
               ylab="Sinergy",xaxt="n",cex.lab=2,
	       cex.main=2, col="blue",xpd=T);
arrows(pos,as.numeric(tab1neg[5,1:6]-tab1neg_var[5,1:6]),pos,as.numeric(tab1neg[5,1:6]+tab1neg_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);

par(mar=c(2,5,2,2));
pos<-barplot(tabNC_mean,cex.axis=2,ylim=c(0,.4),
               ylab="Noise Correlation",xaxt="n",cex.lab=2,
	       cex.main=2, col="blue",xpd=T);
arrows(pos,tabNC_mean-tabNC_var,pos,tabNC_mean+tabNC_var, length=0.,angle=90,code=3,xpd=T);
par(mar=c(0,5,2,2))
pos<-barplot(tabSC_mean,cex.axis=2,ylim=c(0,.4),
               ylab="Signal Correlation",xaxt="n",cex.lab=2,
	       cex.main=2, col="blue",xpd=T);
arrows(pos,tabSC_mean-tabSC_var,pos,tabSC_mean+tabSC_var, length=0.,angle=90,code=3,xpd=T);
par(mar=c(8,5,0,2))
barplot(rep(NA,6),frame=F,axes=F,xlab="",ylab="",ylim=c(0,1));
text(pos,par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
#legend("topright",legend=c("ADF","ASI","NSM"),fill=c("orange","red","yellow"),cex=1);
dev.off()
#}
