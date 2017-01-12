nbars = 5
hmax=1.5
f=1.5;
tt196<-vector(length=nbars);
tt404<-vector(length=nbars);
tt402<-vector(length=nbars);
tt435<-vector(length=nbars);
tt196_sd<-vector(length=nbars);
tt404_sd<-vector(length=nbars);
tt402_sd<-vector(length=nbars);
tt435_sd<-vector(length=nbars);
clist=c("red","blue","green","orange","purple");

i=0;
for(lab in c("Hpi","Hlscv","Hscv","kNN")){
	i=i+1;
	tt196[i]=mean(read.table(file=paste("QL196","_",lab,".dat",sep=""))$V7);
	tt196_sd[i]=sd(read.table(paste("QL196","_",lab,".dat",sep=""))$V7);
	tt404[i]=mean(read.table(file=paste("QL404","_",lab,".dat",sep=""))$V7);
	tt404_sd[i]=sd(read.table(paste("QL404","_",lab,".dat",sep=""))$V7);
	tt402[i]=mean(read.table(file=paste("QL402","_",lab,".dat",sep=""))$V7);
	tt402_sd[i]=sd(read.table(paste("QL402","_",lab,".dat",sep=""))$V7);
	tt435[i]=mean(read.table(file=paste("QL435","_",lab,".dat",sep=""))$V7);
	tt435_sd[i]=sd(read.table(paste("QL435","_",lab,".dat",sep=""))$V7);
}

tt196[nbars]=read.table("QL196_unbiased.dat")[1,1];
tt196_sd[nbars]=read.table("QL196_unbiased.dat")[1,2];
tt404[nbars]=read.table("QL404_unbiased.dat")[1,1];
tt404_sd[nbars]=read.table("QL404_unbiased.dat")[1,2];
tt402[nbars]=read.table("QL402_unbiased.dat")[1,1];
tt402_sd[nbars]=read.table("QL402_unbiased.dat")[1,2];
tt435[nbars]=read.table("QL435_unbiased.dat")[1,1];
tt435_sd[nbars]=read.table("QL435_unbiased.dat")[1,2];

layout(matrix(c(1,2,3,4,5,6,7,8,8,8,9,10,11,12),nrow=2,byrow=T),heights=c(1,1))

par(mar=c(0,5,2,3))
tt<-tt196[1:(nbars-1)];
tt_sd<-tt196_sd[1:(nbars-1)];
bar<-barplot(tt,ylim=c(0,hmax),col=clist[1:(nbars-1)],ylab="Channel Capacity",cex.lab=2,main="Wild-type",cex.axis=2)
arrows(bar,tt-f*tt_sd,bar,tt+f*tt_sd,length=0,angle=90,code=3)

tt<-tt196[c(1,nbars)];
tt_sd<-tt196_sd[c(1,nbars)];
bar<-barplot(tt,ylim=c(0,hmax),col=clist[c(1,nbars)],cex.lab=2,main="Wild-type",cex.axis=2)
arrows(bar,tt-f*tt_sd,bar,tt+f*tt_sd,length=0,angle=90,code=3)

for(i in 1:nbars){
	tt<-c(tt196[i],tt404[i],tt402[i],tt435[i]);
	tt_sd<-c(tt196_sd[i],tt404_sd[i],tt402_sd[i],tt435_sd[i]);
	bar<-barplot(tt,ylim=c(0,hmax),col=clist[i],cex.lab=2,cex.axis=2)
	arrows(bar,tt-f*tt_sd,bar,tt+f*tt_sd,length=0,angle=90,code=3)
}

par(mar=c(2,5,2,3))
barplot(c(NA),yaxt='n',ylim=c(0,1))
legend("bottom",
		title="Algorithms",
		legend=c("Plug-in method",
			 "Least-square cross validation",
			  "Smoothing cross-validation",
			  "k-nearest neighbours",
			  "Jack knife"),
		fill=clist,
		cex=2)

