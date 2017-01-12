
tabI<-matrix(ncol=4,nrow=5);
tabI1<-matrix(ncol=4,nrow=5);
tabI2<-matrix(ncol=4,nrow=5);
tabI3<-matrix(ncol=4,nrow=5);
tabShu<-matrix(ncol=4,nrow=5);

tabI[,1] <- read.table(file="QL196_I.dat",header=F)$V7;
tabI[,2] <- read.table(file="QL404_I.dat",header=F)$V7;
tabI[,3] <- read.table(file="QL402_I.dat",header=F)$V7;
tabI[,4] <- read.table(file="QL435_I.dat",header=F)$V7;

tabI1[,1] <- read.table(file="QL196_I1.dat",header=F)$V7;
tabI1[,2] <- read.table(file="QL404_I1.dat",header=F)$V7;
tabI1[,3] <- read.table(file="QL402_I1.dat",header=F)$V7;
tabI1[,4] <- read.table(file="QL435_I1.dat",header=F)$V7;

tabI2[,1] <- read.table(file="QL196_I2.dat",header=F)$V7;
tabI2[,2] <- read.table(file="QL404_I2.dat",header=F)$V7;
tabI2[,3] <- read.table(file="QL402_I2.dat",header=F)$V7;
tabI2[,4] <- read.table(file="QL435_I2.dat",header=F)$V7;

tabI3[,1] <- read.table(file="QL196_I3.dat",header=F)$V7;
tabI3[,2] <- read.table(file="QL404_I3.dat",header=F)$V7;
tabI3[,3] <- read.table(file="QL402_I3.dat",header=F)$V7;
tabI3[,4] <- read.table(file="QL435_I3.dat",header=F)$V7;

tabShu[,1] <- read.table(file="QL196_Shuffle.dat",header=F)$V7;
tabShu[,2] <- read.table(file="QL404_Shuffle.dat",header=F)$V7;
tabShu[,3] <- read.table(file="QL402_Shuffle.dat",header=F)$V7;
tabShu[,4] <- read.table(file="QL435_Shuffle.dat",header=F)$V7;

nc_mean <- apply(tabI-tabShu,2,mean);
nc_var <- apply(tabI-tabShu,2,sd);
sc_mean <- apply(tabI1+tabI2+tabI3-tabShu,2,mean);
sc_var <- apply(tabI1+tabI2+tabI3-tabShu,2,sd);

pdf("Fig2.pdf",height=7,width=4)

layout(matrix(c(1,2,3),ncol=1));
par(mar=c(1.5,8,1.5,2))
pos_sc<-barplot(sc_mean,beside=T,cex.axis=2,ylim=c(0,0.5),yaxt='n',
		ylab="Signal Correlation\n(bits)",xaxt="n",cex.lab=2,
		cex.main=2,
		col=c("black","blue","red","purple"));
axis(2,at=c(0,0.3,0.5),cex.axis=2);
arrows(pos_sc,sc_mean-sc_var,pos_sc,sc_mean+sc_var, length=0,angle=90,code=3,xpd=T);

par(mar=c(1.5,8,1.5,2))
pos_nc<-barplot(nc_mean,beside=T,cex.axis=2,ylim=c(.5,0),
		ylab="Noise Correlation\n(bits)",xaxt="n",cex.lab=2,
		cex.main=2,
		col=c("black","blue","red","purple"));
arrows(pos_nc,nc_mean-nc_var,pos_nc,nc_mean+nc_var, length=0,angle=90,code=3,xpd=T);
par(mar=c(2,8,0,2));
plot(1,type='n',frame=F,axes=F,ylim=c(0,1),xlim=c(-0.1,4.7),xlab="",ylab="");
text(x=pos_sc,y=rep(1,4),pos=2, labels = c("WT","tph-1(-)","daf-7(-)","tph-1(-);daf-7(-)"),srt = 60, xpd = T, cex=2);

dev.off()
