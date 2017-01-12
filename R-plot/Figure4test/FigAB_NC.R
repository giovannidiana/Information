require(fields)

ShowPlot <- function(GT,pdf=0){

if(pdf==1) pdf(paste("abfig",GT,".pdf",sep=""));
tab<-read.table(paste("../../NC",GT,"_Gaus.dat",sep=""),header=F)
par(mar=c(6,6,6,6))

image.plot(seq(.5,1.5,length=20),
	seq(.5,1.5,length=20),
	matrix(tab$V7,nrow=20),
	labcex=2,
	main=paste(GT,": Noise correlation",sep=""),
	xlab="NOISE",
	ylab="CORRELATION",
	cex.lab=2,
	horizontal=T,
	cex.axis=2)
#points(x=1,y=1,col="red",pch=7,cex=2)
#text(x=1.2,y=1,"We are here!",col="red",cex=1.5) 
if(pdf==1) dev.off();
}
