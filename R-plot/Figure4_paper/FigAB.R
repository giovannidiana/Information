require(fields)

ShowPlot <- function(GT,pdf=0){

if(pdf==1) pdf(paste("abfig",GT,".pdf",sep=""));
tab<-read.table(paste("../../ab2",GT,"_Gaus.dat",sep=""),header=F)
tab1<-read.table(paste("../../n1","ab2",GT,"_Gaus.dat",sep=""),header=F)
tab2<-read.table(paste("../../n2","ab2",GT,"_Gaus.dat",sep=""),header=F)
tab3<-read.table(paste("../../n3","ab2",GT,"_Gaus.dat",sep=""),header=F)
par(mar=c(6,6,6,6))
blist <- seq(-0.16,.9,length.out=100);
colpal <- colorRampPalette(c("magenta","purple","blue","cyan","white","green","yellow","orange","red"))(length(blist)-1);

#print((tab1$V7+tab2$V7+tab3$V7-tab$V7)[211]);

image.plot(seq(.5,2,length=60),
	seq(.5,1.5,length=60),
	matrix(tab1$V7+tab2$V7+tab3$V7-tab$V7,nrow=60),
	labcex=2,
	main=paste(GT,": Redundant Information",sep=""),
	xlab="NOISE",
	ylab="CORRELATION",
	cex.lab=2,
	horizontal=T,
	cex.axis=2,
	breaks=blist,
	col=colpal)
#points(x=1,y=1,col="red",pch=7,cex=2)
#text(x=1.2,y=1,"We are here!",col="red",cex=1.5) 
if(pdf==1) dev.off();
}
