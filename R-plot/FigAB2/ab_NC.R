require(fields)


ShowPlot2 <- function(GT,ncolor, labelon){

  tab<-read.table(paste("../../ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab1<-read.table(paste("../../n1","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab2<-read.table(paste("../../n2","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab3<-read.table(paste("../../n3","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tabShuffle<-read.table(paste("../../Shuffle","ab2",GT,"_Gaus.dat",sep=""),header=F);

  min=-.3;
  max=.5;
  colbreaks <-seq(length=(ncolor+1), from=min, by=(max-min)/ncolor)
  colortab <- rainbow(ncolor)
  levelsvec <-seq(min,max, by=.05)

  par(mar=c(6,6,6,6))
  image.plot(
	     seq(.5,2,length=60),
	     seq(.5,2,length=60),
             matrix(tab$V7-tabShuffle$V7,nrow=60),
             main=paste(GT,": Noise Correlation",sep=""),
	     xaxt='n',
	     yaxt='n',
             xlab="Noise",
             ylab="Correlation",
             breaks=colbreaks,
             col=colortab)
  axis(1,at=seq(.5,2,.5));
  axis(2,at=seq(.5,2,.5));

  contour(
	  seq(.5,2,length=60),
	  seq(.5,2,length=60),
          matrix(tab$V7-tabShuffle$V7,nrow=60),
          levels = levelsvec,
          labcex=.75,
          drawlabels = labelon,
          method="flattest",
          horizontal=T,
          add = TRUE)
  axis(1,at=seq(.5,2,.5));
  axis(2,at=seq(.5,2,.5));
}

pdf("fig4_NC.pdf",width=16,height=8);
par(mfrow=c(2,4));
ShowPlot2("QL196",256,FALSE); ShowPlot2("QL404",256,FALSE); ShowPlot2("QL402",256,FALSE); ShowPlot2("QL435",256,FALSE)
ShowPlot2("QL196",256,TRUE); ShowPlot2("QL404",256,TRUE); ShowPlot2("QL402",256,TRUE); ShowPlot2("QL435",256,TRUE)
par(mfrow=c(1,1))
dev.off();
