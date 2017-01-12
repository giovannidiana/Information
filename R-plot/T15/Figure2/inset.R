tabSC<-matrix(ncol=4,nrow=5);
tabNC<-matrix(ncol=4,nrow=5);

tabSC[,1] <- read.table(file="QL196_SC.dat",header=F)$V1;
tabSC[,2] <- read.table(file="QL404_SC.dat",header=F)$V1;
tabSC[,3] <- read.table(file="QL402_SC.dat",header=F)$V1;
tabSC[,4] <- read.table(file="QL435_SC.dat",header=F)$V1;

tabNC[,1] <- read.table(file="QL196_NC.dat",header=F)$V1;
tabNC[,2] <- read.table(file="QL404_NC.dat",header=F)$V1;
tabNC[,3] <- read.table(file="QL402_NC.dat",header=F)$V1;
tabNC[,4] <- read.table(file="QL435_NC.dat",header=F)$V1;

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
