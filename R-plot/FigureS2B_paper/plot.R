nbars = 5
hmax=1.5
f=1
tt<-vector(length=nbars);
tt_sd<-vector(length=nbars);
clist=c("red","blue","green","orange","purple");

GT="QL196"
i=0;
for(lab in c("Hpi","Hlscv","Hscv","Hlscv_2")){
	i=i+1;
	tt[i]=mean(read.table(file=paste(GT,"_",lab,".dat",sep=""))$V7);
	tt_sd[i]=sd(read.table(paste(GT,"_",lab,".dat",sep=""))$V7);
}

tt[nbars]=read.table(paste(GT,"_unbiased.dat",sep=""))[1,1];
tt_sd[nbars]=read.table(paste(GT,"_unbiased.dat",sep=""))[1,2];

layout(matrix(c(1,2),nrow=2),heights=c(1,1))

par(mar=c(0,5,2,3))
bar<-barplot(tt,ylim=c(0,hmax),col=clist,ylab="Channel Capacity",cex.lab=2,main=GT,cex.axis=2)
arrows(bar,tt-f*tt_sd,bar,tt+f*tt_sd,length=.1,angle=90,code=3)

par(mar=c(2,5,2,3))
barplot(c(NA),yaxt='n',ylim=c(0,1))
legend("bottom",
		legend=c("Plug-in",
			 "Least-square cross validation",
			  "Smoothing cross-validation",
			  "LSCV half bandwidth",
			  "Jack knife"),
		fill=clist,
		cex=2)

