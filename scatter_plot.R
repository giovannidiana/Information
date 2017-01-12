GT="QL196"
T2=20

mydata <- read.table("/home/diana/workspace/data/dataset-add-2/expression5.dat", header=FALSE);

pdf("scatter_plot.pdf",width=8,height=10);
lab=1;
layout(matrix(1:20,ncol=4,byrow=T))
par(mar=c(2,2,2,2))
for(GT in c("QL196","QL404","QL402","QL435")){
	data0 <- subset(mydata,V3==GT & V6==T2 & V4==6);
        names(data0)<-c("B","BD","GT","Day","F2","T2","ADF","ASI","NSM");
	data12 <- data.frame(data0$ADF,data0$ASI,as.numeric(factor(data0$F2)));
	data13 <- data.frame(data0$ADF,data0$NSM,as.numeric(factor(data0$F2)));
	data23 <- data.frame(data0$ASI,data0$NSM,as.numeric(factor(data0$F2)));


	if(lab==1){
		maint=c("ADF-ASI","ADF-NSM","ASI-NSM");
	} else {
		maint=rep("",3);
	}
	

	plot.new();
	legend("center",legend=GT,box.lwd=0);

	plot(data12[,1:2]/1e6,
			xlim=c(6,35),
			xlab="",
			ylim=c(0,50),
			ylab=GT,
			main=maint[1],
			col=rainbow(6,alpha=0.7)[data12[,3]],
			pch=16,cex=.5);
	
	plot(data13[,1:2]/1e6,
			xlim=c(6,35),
			xlab="",
			ylim=c(30,80),
			ylab="",
			main=maint[2],
			col=rainbow(6,alpha=0.7)[data13[,3]],
			pch=16,cex=.5)
	plot(data23[,1:2]/1e6,
			xlim=c(0,50),
			xlab="",
			ylim=c(30,80),
			ylab="",
			main=maint[3],
			col=rainbow(6,alpha=0.7)[data23[,3]],
			pch=16,cex=.5)

	lab=0;
}

plot.new();
foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);
legend("center",legend=foodlist,fill=rainbow(6,alpha=0.7));

dev.off()
