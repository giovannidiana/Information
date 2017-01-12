tabSC<-matrix(ncol=4,nrow=5);
tabNC<-matrix(ncol=4,nrow=5);

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

tabSC<-tabI1+tabI2+tabI3-tabShu
tabNC<-tabI-tabShu

sc_mean <- apply(tabSC,2,mean);
nc_mean <- apply(tabNC,2,mean);

pts <- matrix(ncol=2,nrow=4);
for(i in 1:4){
	pts[i,] = c(nc_mean[i],sc_mean[i]);
}
plot(seq(0,.8,.01),seq(0,.8,.01),type='l',lwd=3,xaxt='n',yaxt='n',
     xlab="",
     ylab="");

points(pts,pch=c(22,23,21,24),bg=c("black","blue","red","purple"),cex=3);
