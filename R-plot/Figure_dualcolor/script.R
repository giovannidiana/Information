library(MASS)

data27_G<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_2E+7-d3.0/daf-7_dual_colour_2E+7-d3.0_data_asi.csv",sep=',');
data27_R<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_2E+7-d3.0/daf-7_dual_colour_2E+7-d3.0_data_asired.csv",sep=',');
data67_G<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_6.32E+7-d3.0/daf-7_dual_colour_6.32E+7-d3.0_data_asi.csv",sep=',');
data67_R<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_6.32E+7-d3.0/daf-7_dual_colour_6.32E+7-d3.0_data_asired.csv",sep=',');
data68_G<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_6.32E+8-d3.0/daf-7_dual_colour_6.32E+8-d3.0_data_asi.csv",sep=',');
data68_R<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour_6.32E+8-d3.0/daf-7_dual_colour_6.32E+8-d3.0_data_asired.csv",sep=',');
data29_G<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour-d3.0/daf-7_dual_colour-d3.0_data_asi.csv",sep=',')
data29_R<-read.table("/home/diana/workspace/data/dataset-dualcolor/20120521-daf-7_dual_colour-d3.0/daf-7_dual_colour-d3.0_data_asired.csv",sep=',')

cond27<-(data27_R$V2>0 & data27_R$V3>0 & data27_G$V2>0 & data27_G$V3>0)
data27<-data.frame(green=data27_G[cond27,4],red=data27_R[cond27,4])
data27<-data27[-c(28),];

cond67<-(data67_R$V2>0 & data67_R$V3>0 & data67_G$V2>0 & data67_G$V3>0)
data67<-data.frame(green=data67_G[cond67,4],red=data67_R[cond67,4])

cond68<-(data68_R$V2>0 & data68_R$V3>0 & data68_G$V2>0 & data68_G$V3>0)
data68<-data.frame(green=data68_G[cond68,4],red=data68_R[cond68,4])

cond29<-(data29_R$V2>0 & data29_R$V3>0 & data29_G$V2>0 & data29_G$V3>0)
data29<-data.frame(green=data29_G[cond29,4],red=data29_R[cond29,4])

data<-rbind(data27,data67,data68,data29);
means<-apply(data,2,mean);
data<-data.frame(green=data[,1]/means[1],red=data[,2]/means[2])
data27<-data.frame(green=data27[,1]/means[1],red=data27[,2]/means[2])
data67<-data.frame(green=data67[,1]/means[1],red=data67[,2]/means[2])
data68<-data.frame(green=data68[,1]/means[1],red=data68[,2]/means[2])
data29<-data.frame(green=data29[,1]/means[1],red=data29[,2]/means[2])

plot(data27,pch=15,cex=1.2,xlim=c(0.2,2),ylim=c(0.2,2))
points(data67,pch=15,col="red",cex=1.2)
points(data68,pch=15,col="orange",cex=1.2)
points(data29,pch=15,col="magenta",cex=1.2)
l<-lm(data$red ~ 0 + data$green)
xx<-seq(0,2,by=1e-1)
lines(xx,l$coefficients[1]*xx)
text(x=.6,y=1.4,paste(expression(rho),"=",""))
legend("bottomright",legend=c("2e7","6e7","6e8","2e9"),pch=c(15,15,15,15),col=c("black","red","orange","magenta"),cex=1.2)

