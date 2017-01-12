gt=196

pdf(paste("chart",gt,".pdf",sep=""))

tab<-read.table(paste("infobyfood_",gt,".dat",sep=""))

names(tab)<-c("S basal","2.0E+07","6.3E+07","6.3E+08","2.0E+09","1.10E+10");

colors<-c("red","green","blue")

barplot(as.matrix(tab),
	main=paste("QL",gt,sep=""),
	xlab="Food level (bacteria concentration)",
	ylab="Information (bits)",
	ylim=c(0,1),
	beside=TRUE,
	col=colors)

legend("topright", c("ADF","ASI","NSM"), cex=1.3, bty="n", fill=colors)

dev.off()

