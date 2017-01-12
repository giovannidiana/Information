require(fields)


ShowPlot <- function(GT,pdf=0){

  tab<-read.table(paste("../../ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab1<-read.table(paste("../../n1","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab2<-read.table(paste("../../n2","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab3<-read.table(paste("../../n3","ab2",GT,"_Gaus.dat",sep=""),header=F);
  if(pdf==1) pdf(paste("abfig",GT,".pdf",sep=""));
  par(mar=c(6,6,6,6))
  linecol <-terrain.colors(12)

  contour(seq(.5,2,length=60),
        seq(.5,2,length=60),
        matrix(tab$V7,nrow=60),
        labcex=.75,
        main=paste(GT,": INFORMATION",sep=""),
        xlab="Noise",
        ylab="Correlation",
        cex.lab=1,
        horizontal=T,
  add=TRUE,
        cex.axis=1)
#points(x=1,y=1,col="red",pch=7,cex=2)
#text(x=1.2,y=1,"We are here!",col="red",cex=1.5)

#line.list <- contourLines(x, y, tab)
#invisible(lapply(line.list, lines, lwd=3, col=adjustcolor(2, .3)))

if(pdf==1) dev.off();
}

ShowPlot2 <- function(GT,ncolor, labelon){

  tab<-read.table(paste("../../ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab1<-read.table(paste("../../n1","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab2<-read.table(paste("../../n2","ab2",GT,"_Gaus.dat",sep=""),header=F);
  tab3<-read.table(paste("../../n3","ab2",GT,"_Gaus.dat",sep=""),header=F);

  min=-.5;
  max=1;
  colbreaks <-seq(length=(ncolor+1), from=min, by=(max-min)/ncolor)
  colortab <- rainbow(ncolor)
  levelsvec <-seq(min,max, by=0.1)

  par(mar=c(6,6,6,6))
  image(
	     seq(.5,2,length=60),
	     seq(.5,2,length=60),
             matrix(tab1$V7+tab2$V7+tab3$V7-tab$V7,nrow=60),
             main=paste(GT,": REDUNDANCY",sep=""),
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
          matrix(tab1$V7+tab2$V7+tab3$V7-tab$V7,nrow=60),
          levels = levelsvec,
          labcex=.75,
          drawlabels = labelon,
          method="flattest",
          horizontal=T,
          add = TRUE)
}

pdf("fig4_red.pdf",width=16,height=8);
par(mfrow=c(2,4));
ShowPlot2("QL196",256,FALSE); ShowPlot2("QL404",256,FALSE); ShowPlot2("QL402",256,FALSE); ShowPlot2("QL435",256,FALSE)
ShowPlot2("QL196",256,TRUE); ShowPlot2("QL404",256,TRUE); ShowPlot2("QL402",256,TRUE); ShowPlot2("QL435",256,TRUE)
par(mfrow=c(1,1))
dev.off();
