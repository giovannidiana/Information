require(fields)

ShowPlot <- function(GT,pdf=0){

if(pdf==1) pdf(paste("abfig",GT,".pdf",sep=""));
tab<-read.table(paste("../../ab",GT,"_Gaus.dat",sep=""),header=F)
tab1<-read.table(paste("../../n1",GT,"_Gaus.dat",sep=""),header=F)
tab2<-read.table(paste("../../n2",GT,"_Gaus.dat",sep=""),header=F)
tab3<-read.table(paste("../../n3",GT,"_Gaus.dat",sep=""),header=F)
tabNC<-read.table(paste("../../NC",GT,"_Gaus.dat",sep=""),header=F)
par(mar=c(6,6,6,6))

image.plot(seq(.5,1.5,length=20),
	seq(.5,1.5,length=20),
	matrix(tab1$V7+tab2$V7+tab3$V7-tab$V7+tabNC$V7,nrow=20),
	labcex=2,
	main=paste(GT,": Signal correlation",sep=""),
	xlab="NOISE",
	ylab="CORRELATION",
	cex.lab=2,
	horizontal=T,
	cex.axis=2)
#points(x=1,y=1,col="red",pch=7,cex=2)
#text(x=1.2,y=1,"We are here!",col="red",cex=1.5) 
if(pdf==1) dev.off();
}
