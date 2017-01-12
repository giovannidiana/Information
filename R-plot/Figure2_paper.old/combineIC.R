
tabSC<-matrix(ncol=4,nrow=5);
tabNC<-matrix(ncol=4,nrow=5);
tabShu<-matrix(ncol=4,nrow=5);

tabSC[,1] <- read.table(file="QL196_SC.dat",header=F)$V1;
tabSC[,2] <- read.table(file="QL404_SC.dat",header=F)$V1;
tabSC[,3] <- read.table(file="QL402_SC.dat",header=F)$V1;
tabSC[,4] <- read.table(file="QL435_SC.dat",header=F)$V1;

tabNC[,1] <- read.table(file="QL196_NC.dat",header=F)$V1;
tabNC[,2] <- read.table(file="QL404_NC.dat",header=F)$V1;
tabNC[,3] <- read.table(file="QL402_NC.dat",header=F)$V1;
tabNC[,4] <- read.table(file="QL435_NC.dat",header=F)$V1;

tabShu[,1] <- read.table(file="QL196_Shuffle.dat",header=F)$V1;
tabShu[,2] <- read.table(file="QL404_Shuffle.dat",header=F)$V1;
tabShu[,3] <- read.table(file="QL402_Shuffle.dat",header=F)$V1;
tabShu[,4] <- read.table(file="QL435_Shuffle.dat",header=F)$V1;

sc_mean <- apply(tabSC-tabShu,2,mean);
sc_var <- apply(tabSC-tabShu,2,sd);
nc_mean <- apply(tabNC-tabShu,2,mean);
nc_var <- apply(tabNC-tabShu,2,sd);

#pdf("Fig2.pdf",height=7,width=4)

layout(matrix(c(1,2,3),ncol=1));
par(mar=c(1.5,8,1.5,2))
pos_sc<-barplot(sc_mean,beside=T,cex.axis=2,ylim=c(0,.5),
		ylab="Signal Correlation\n(bits)",xaxt="n",cex.lab=2,
		cex.main=2,
		col=c("black","blue","red","purple"));
arrows(pos_sc,sc_mean-sc_var,pos_sc,sc_mean+sc_var, length=0,angle=90,code=3,xpd=T);

par(mar=c(1.5,8,1.5,2))
pos_nc<-barplot(nc_mean,beside=T,cex.axis=2,ylim=c(-2,2),
		ylab="Noise Correlation\n(bits)",xaxt="n",cex.lab=2,
		cex.main=2,
		col=c("black","blue","red","purple"));
arrows(pos_nc,nc_mean-nc_var,pos_nc,nc_mean+nc_var, length=0,angle=90,code=3,xpd=T);
par(mar=c(2,8,0,2));
plot(1,type='n',frame=F,axes=F,ylim=c(0,1),xlim=c(-0.1,4.7),xlab="",ylab="");
text(x=pos_sc,y=rep(1,4),pos=2, labels = c("WT","tph-1(-)","daf-7(-)","tph-1(-);daf-7(-)"),srt = 60, xpd = T, cex=2);

#dev.off()
