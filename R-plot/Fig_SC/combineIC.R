require(abind);

tab<-matrix(ncol=4,nrow=5);

tab[,1] <- read.table(file="QL196_all.dat",header=F)$V1;
tab[,2] <- read.table(file="QL404_all.dat",header=F)$V1;
tab[,3] <- read.table(file="QL402_all.dat",header=F)$V1;
tab[,4] <- read.table(file="QL435_all.dat",header=F)$V1;

t_mean <- apply(tab,2,mean);
t_var <- apply(tab,2,sd);

pos<-barplot(t_mean,beside=T,cex.axis=2,ylim=c(0,1.3),
		ylab="Information (bits)",xaxt="n",cex.lab=2,
		cex.main=2,
		col=c("blue","orange","red","yellow"));
arrows(pos,t_mean-t_var,pos,t_mean+t_var, length=0.05,angle=90,code=3,xpd=T);

