require(RColorBrewer);

tabgt<-vector(length=4);
tabvar<-vector(length=4);

colpal_196<-brewer.pal(n=7,"Greys");
colpal_402<-brewer.pal(n=7,"Reds");
colpal_404<-brewer.pal(n=7,"Blues");
colpal_435<-brewer.pal(n=7,"Purples");
colpal=c(colpal_196[7], colpal_402[7], colpal_404[7], colpal_435[7]);

k=0;
for(GTtest in c("N2","QL101","QL282","QL300")){
	k<-k+1;
	tab <- read.table(file=paste("info",GTtest,".dat",sep=""),header=F)$V7;

	tabgt[k]<-mean(tab);
	tabvar[k]<-sd(tab);
}

pdf("Fig1.pdf",height=7,width=4);

pos<-barplot(tabgt,
	     ylim=c(0,1),
	     ylab="Information (bits)",
	     cex.axis=2,
	     cex.lab=2,
	     col=cbind(colpal_196[7],colpal_404[7],colpal_402[7],colpal_435[7]));
arrows(pos,tabgt+tabvar,pos,tabgt-tabvar, length=0,angle=90,code=3,xpd=T);
dev.off();
