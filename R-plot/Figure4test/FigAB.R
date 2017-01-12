require(fields)

ShowPlot <- function(GT,pdf=0){

if(pdf==1) pdf(paste("abfig",GT,".pdf",sep=""));
tab<-read.table(paste("../../ab2",GT,"_Gaus.dat",sep=""),header=F)
tab1<-read.table(paste("../../n1ab2",GT,"_Gaus.dat",sep=""),header=F)
tab2<-read.table(paste("../../n2ab2",GT,"_Gaus.dat",sep=""),header=F)
tab3<-read.table(paste("../../n3ab2",GT,"_Gaus.dat",sep=""),header=F)

if(GT=="QL196") color=col2rgb("black")
if(GT=="QL402") color=col2rgb("red");
if(GT=="QL404") color=col2rgb("blue");
if(GT=="QL435") color=col2rgb("purple");

pts<-cbind(tab$V7,tab1$V7+tab2$V7+tab3$V7-tab$V7);

#plot(1:1,type='n',xlim=range(tab$V7),ylim=range(tab1$V7+tab2$V7+tab3$V7-tab$V7));
points(pts,col=rgb(color[1]/256,color[2]/256,color[3]/256,alpha=.1),pch=19);
}

plot(1:1,type='n',xlim=c(-.1,2),ylim=c(-.6,1),
		xlab="Information",
		ylab="Redundancy");
for(GT in c("QL196","QL402","QL404","QL435")) ShowPlot(GT,0)
lines(-10:10,-10:10)
