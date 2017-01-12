require(abind);
require(RColorBrewer)

alpha_usr <- function(alpha,th){
	bo<-alpha>th;
	vec=alpha;
	for(i in 1:length(alpha)){
		if(!bo[i]) vec[i]=th;
	}
	vec
}

Print3DInfos <- function(GTtest,YLABS){
#GTtest="QL196"
#GTtest="QL402"
#GTtest="QL404"
#GTtest="QL435"
pdf(paste("Fig3",GTtest,".pdf",sep=""));
layout(c(1,2,3),heights=c(1,1,.5));
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
th=0.1;
alphas=alpha_usr(tabAAN_mean[1:6]/max(tabAAN_mean[1:6]),th);
if(GTtest=="QL196") {
	mt="WT";
	colorpal=rgb(0,0,0,alphas);
}
if(GTtest=="QL402"){ 
	mt="daf-7(-)";
	newred=col2rgb("#981B1E")/255;
	colorpal=rgb(newred[1],newred[2],newred[3],alphas);
}
if(GTtest=="QL404"){
	mt="tph-1(-)";
	colorpal=rgb(0,0,1,alphas);
}
if(GTtest=="QL435"){
	mt="tph-1(-);daf-7(-)";
	rgb_purple=col2rgb("purple")/255;
	colorpal=rgb(rgb_purple[1],rgb_purple[2],rgb_purple[3],alphas);
}

#layout(matrix(c(1,1,1,1,
#	        2,2,2,2,
#		3,3,3,3,
#		4,5,6,7,
#		8,8,8,8,
#		9,9,9,9),
#	ncol=4,byrow=T),heights=c(2.,.8,.8,.6,.8,0.6));

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
	       main=mt,
               ylab=ulab,xaxt="n",cex.lab=2,las=1,yaxt='n',
	       cex.main=2, col=colorpal,xpd=T);
axis(2,at=c(0,.2,.4,.6),las=1,cex.axis=1.5);
arrows(pos,as.numeric(tab1pos[5,1:6]-tab1pos_var[5,1:6]),pos,as.numeric(tab1pos[5,1:6]+tab1pos_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);

par(mar=c(4,6,0,0));
if(YLABS==1){
	ulab="Synergy";
} else ulab="";
pos<-barplot(as.numeric(tab1neg[5,1:6]),cex.axis=1.5,ylim=c(.6,0),
               ylab=ulab,xaxt="n",cex.lab=2,las=1,yaxt='n',
	       cex.main=2, col=colorpal,xpd=T);
axis(2,at=c(0,.2,.4,.6),las=1,cex.axis=1.5);
arrows(pos,as.numeric(tab1neg[5,1:6]-tab1neg_var[5,1:6]),pos,as.numeric(tab1neg[5,1:6]+tab1neg_var[5,1:6]), length=0.,angle=90,code=3,xpd=T);

par(mar=c(8,6,0,0))
barplot(rep(NA,6),axes=F,xlab="",ylab="",ylim=c(0,1));
text(pos,par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
}
