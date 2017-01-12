require(abind);
require(RColorBrewer)

Print3DInfos <- function(GTtest,YLABS){
#GTtest="QL196"
#GTtest="QL402"
#GTtest="QL404"
#GTtest="QL435"
#pdf(paste("Fig3",GTtest,".pdf",sep=""),width=4,height=12);
#X11(width=5,height=12);
# Label of food to be used
foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);
# select genotype
# Extract informations from file:
# The format of the input file is
# row 1: information broken down by food for the joint 3D distribution + total mutual 
#        information (Channel capacity because it is the optimized one)
# row 2-4 Mutual information between food and single neurons obtained from the intput_prob
#         optimized for the 3D data. Information per food level + total
# 
tabInfo <- read.table(file=paste(GTtest,"_all.dat",sep=""),header=F);
# Combine the redundancy to tabInfo
tabInfo <- rbind(tabInfo,apply(tabInfo[2:4,],2,sum)-tabInfo[1,7]);

tabADF <- read.table(file=paste(GTtest,"inpdf1.dat",sep=""),header=F);
tabASI <- read.table(file=paste(GTtest,"inpdf2.dat",sep=""),header=F);
tabNSM <- read.table(file=paste(GTtest,"inpdf3.dat",sep=""),header=F);
tabAAN <- read.table(file=paste(GTtest,"_inpdf3D.dat",sep=""),header=F);

tabADF_mean <- apply(as.matrix(tabADF),2,mean);
tabASI_mean <- apply(as.matrix(tabASI),2,mean);
tabNSM_mean <- apply(as.matrix(tabNSM),2,mean);
tabAAN_mean <- apply(as.matrix(tabAAN),2,mean);
tabADF_var <- apply(as.matrix(tabADF),2,sd);
tabASI_var <- apply(as.matrix(tabASI),2,sd);
tabNSM_var <- apply(as.matrix(tabNSM),2,sd);
tabAAN_var <- apply(as.matrix(tabAAN),2,sd);

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
if(GTtest=="QL196") {
	mt="WT";
	colorpal=brewer.pal(n=7,"Greys");
}
if(GTtest=="QL402"){ 
	mt="daf-7(-)";
	colorpal=brewer.pal(n=7,"Reds");
}
if(GTtest=="QL404"){
	mt="tph-1(-)";
	colorpal=brewer.pal(n=7,"Blues");
}
if(GTtest=="QL435"){
	mt="tph-1(-);daf-7(-)";
	colorpal=brewer.pal(n=7,"Purples");
}

#layout(matrix(c(1,1,1,1,
#	        2,2,2,2,
#		3,3,3,3,
#		4,5,6,7,
#		8,8,8,8,
#		9,9,9,9),
#	ncol=4,byrow=T),heights=c(2.,.8,.8,.6,.8,0.6));
par(mar=c(0,6,2,0),mgp=c(4,.5,0))

if(YLABS==1){
	ulab="Information (bits)";
} else ulab="";
pos<-barplot(as.matrix(tab1),cex.axis=1.5,ylim=c(0,2),
		ylab=ulab,xaxt="n",cex.lab=2,
		main=mt,cex.main=2,las=1,
		col=colorpal[c(4,5,6)]);
posmat<-matrix(rep(pos,3),ncol=6,byrow=T);
arrows(posmat,apply(as.matrix(tab1),2,cumsum)-tab1_var,posmat,apply(as.matrix(tab1),2,cumsum)+tab1_var, length=0.,angle=90,code=3,xpd=T);
lines(seq(pos[1]-0.6,pos[6]+0.6,length=10),rep(tabInfo[1,7],10),lwd=2,lty=2);

par(mar=c(0,6,4,0));
tab1pos=tabInfo;
tab1pos[tabInfo<0]<-NA;
tab1neg=-tabInfo;
tab1neg[tabInfo>0]<-NA;

tab1pos_var=tabInfo_var;
tab1pos_var[tabInfo<0]<-NA;
tab1neg_var=tabInfo_var;
tab1neg_var[tabInfo>0]<-NA;

if(YLABS==1){
	ulab="Redundancy";
} else ulab="";
pos<-barplot(as.numeric(tab1pos[5,1:6]),cex.axis=1.5,ylim=c(0,.6),
               ylab=ulab,xaxt="n",cex.lab=2,las=1,yaxt='n',
	       cex.main=2, col=colorpal[7],xpd=T);
axis(2,at=c(0,.2,.4,.6),las=1,cex.axis=1.5);
arrows(pos,as.numeric(tab1pos[5,1:6]-tab1pos_var[5,1:6]),pos,as.numeric(tab1pos[5,1:6]+tab1pos_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);

par(mar=c(4,6,0,0));
if(YLABS==1){
	ulab="Synergy";
} else ulab="";
pos<-barplot(as.numeric(tab1neg[5,1:6]),cex.axis=1.5,ylim=c(.6,0),
               ylab=ulab,xaxt="n",cex.lab=2,las=1,yaxt='n',
	       cex.main=2, col=colorpal[7],xpd=T);
axis(2,at=c(0,.2,.4,.6),las=1,cex.axis=1.5);
arrows(pos,as.numeric(tab1neg[5,1:6]-tab1neg_var[5,1:6]),pos,as.numeric(tab1neg[5,1:6]+tab1neg_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);

par(mar=c(0,6,0,0));

if(YLABS==1){
	ulab="Probability";
} else ulab="";
pos<-barplot(tabAAN_mean[1:6],ylim=c(0,.5),
               ylab=ulab,xaxt="n",yaxt='n',cex.lab=2,col=colorpal[7],
	       cex.main=2 ,xpd=T);
axis(2,at=c(0,0.25,.5),cex.axis=1.5,las=1)
arrows(pos,tabAAN_mean[1:6]-tabAAN_var[1:6],pos,tabAAN_mean[1:6]+tabAAN_var[1:6], length=0.,angle=90,code=3,xpd=T);

par(mar=c(8,6,0,0))
barplot(rep(NA,6),axes=F,xlab="",ylab="",ylim=c(0,1));
text(pos,par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);

par(mar=c(2,0,4,0));
plot.new();

par(mar=c(2,.5,4,.5));
pos<-barplot(tabADF_mean[1:6],ylim=c(0,.6),
               main="ADF",ylab="",xaxt="n",yaxt='n', xpd=T,col=colorpal[4]);
axis(2,at=c(0,0.3,.6),las=1)
arrows(pos,tabADF_mean[1:6]-tabADF_var[1:6],pos,tabADF_mean[1:6]+tabADF_var[1:6], length=0.,angle=90,code=3,xpd=T);

pos<-barplot(tabASI_mean[1:6],ylim=c(0,.6),
               main="ASI",ylab="",xaxt="n",yaxt='n',las=1, xpd=T,col=colorpal[5]);
arrows(pos,tabASI_mean[1:6]-tabASI_var[1:6],pos,tabASI_mean[1:6]+tabASI_var[1:6], length=0.,angle=90,code=3,xpd=T);

pos<-barplot(tabNSM_mean[1:6],ylim=c(0,.6),
               main="NSM",ylab="",xaxt="n",yaxt='n',las=1,xpd=T,col=colorpal[6]);
arrows(pos,tabNSM_mean[1:6]-tabNSM_var[1:6],pos,tabNSM_mean[1:6]+tabNSM_var[1:6], length=0.,angle=90,code=3,xpd=T);

#legend("topright",legend=c("ADF","ASI","NSM"),fill=c("orange","red","yellow"),cex=1);
#dev.off()
}
