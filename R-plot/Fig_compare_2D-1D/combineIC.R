require(abind)

# useful function for noise propagation
R.noise <- function(x,y,z,x.sd,y.sd,z.sd){
	    # x.sd : SD on the correlation
	    
	    w=x.sd^2/(y*z)+1/4*x^2/(z*y)*(y.sd^2/y^2+z.sd^2/z^2);

	    sqrt(w)
}

Print2DInfos <- function(GTtest,XY,printed=F){

if(printed==T) pdf(paste(GTtest,"_",XY,".pdf",sep=""));

foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);
denpar = c(12,6,7,8);
stat<-list(length=6)

ADF<-vector(mode="numeric",length=6);
ASI<-vector(mode="numeric",length=6);
NSM<-vector(mode="numeric",length=6);

ADF.sd<-vector(mode="numeric",length=6);
ASI.sd<-vector(mode="numeric",length=6);
NSM.sd<-vector(mode="numeric",length=6);

COV <- matrix(nrow=6,ncol=9);
COV.sd <- matrix(nrow=6,ncol=9);

for( i in 1:6 ){
	stat<-read.table(file=paste("/home/diana/workspace/JAGS/",GTtest,"_",i,".dat",sep=""));
	ADF[i] <- stat["mu[1]",]$Mean;
	ASI[i] <- stat["mu[2]",]$Mean;
	NSM[i] <- stat["mu[3]",]$Mean;
	
	ADF.sd[i] <- stat["mu[1]",]$SD;
	ASI.sd[i] <- stat["mu[2]",]$SD;
	NSM.sd[i] <- stat["mu[3]",]$SD;

	COV[i,] <- stat[1:9,]$Mean;
	COV.sd[i,] <- stat[1:9,]$SD;
}

for(i in 1:6){
	COV[i,2]    <- COV[i,2]/sqrt(COV[i,1]*COV[i,5])
	COV.sd[i,2] <- R.noise(COV[i,2],COV[i,1],COV[i,5],
			       COV.sd[i,2],COV.sd[i,1],COV.sd[i,5]);
	COV[i,3]    <- COV[i,3]/sqrt(COV[i,1]*COV[i,9])
	COV.sd[i,3] <- R.noise(COV[i,3],COV[i,1],COV[i,9],
			       COV.sd[i,3],COV.sd[i,1],COV.sd[i,9]);
	COV[i,6]    <- COV[i,6]/sqrt(COV[i,9]*COV[i,5])
	COV.sd[i,6] <- R.noise(COV[i,6],COV[i,5],COV[i,9],
			       COV.sd[i,6],COV.sd[i,5],COV.sd[i,9]);
}

COV[,1]<-sqrt(COV[,1]); COV.sd[,1]<-1/(2*sqrt(COV[,1]))*COV.sd[,1];
COV[,5]<-sqrt(COV[,5]); COV.sd[,5]<-1/(2*sqrt(COV[,5]))*COV.sd[,5];
COV[,9]<-sqrt(COV[,9]); COV.sd[,9]<-1/(2*sqrt(COV[,9]))*COV.sd[,9];

if(XY==1) {
	ind=2;
	tit="ADF - ASI";
	Xlab="ADF";
	Ylab="ASI";
}
if(XY==2) {
	ind=3;
	tit="ADF - NSM";
	Xlab="ADF";
	Ylab="NSM";
}
if(XY==3) {
	ind=6;
	tit="ASI - NSM";
	Xlab="ASI";
	Ylab="NSM";
}

tabInfo <- read.table(file=paste(GTtest,"_",XY,".dat",sep=""),header=F);
tabInfo <- rbind(tabInfo,apply(tabInfo[2:3,],2,sum)-tabInfo[1,])

# Load the groups 1 to 5 to calculate the uncertainty
tabInfo_groups <- vector("list",length=5);
for( i in 1:5) {
	tabInfo_groups[[i]] <- read.table(file=paste(GTtest,"_",XY,"_group",i,".dat",sep=""),header=F); 
	tabInfo_groups[[i]] <- rbind(tabInfo_groups[[i]],apply(tabInfo_groups[[i]][2:3,],2,sum)-tabInfo_groups[[i]][1,]);
}
ab <- abind(tabInfo_groups,along=3);
tabInfo_var <- apply(ab,1:2,sd);


layout(matrix(c(1,2,3),ncol=1),heights=c(2,4,4))
par(mar=c(0,2,1,2))
plot.new()
#text(x=.2,y=.5,GTtest,cex=3)
legend("center",legend=c(tit,Xlab,Ylab),fill=c("orange","red","yellow"),cex=2)
legend("right",legend=c("Redundancy"),fill=c("purple"),cex=2)

par(mar=c(2,5,2,2))
pos<-barplot(as.matrix(tabInfo),beside=T,cex.axis=2,
		ylab="Information (bits)",xaxt="n",cex.lab=2,
		col=c("orange","red","yellow","purple"));
arrows(pos,as.matrix(tabInfo)-tabInfo_var,pos,as.matrix(tabInfo)+tabInfo_var, length=0.05,angle=90,code=3,xpd=T);
par(mar=c(9,8,2,12))
plot(1:6,COV[,ind],ylim=c(-.25,.35),type="l",
		pch=19,xlab="", ylab="",
		cex.lab=2,cex.axis=2,xaxt="n",yaxt="n");
axis(2,at=c(-0.2,0,0.2),cex.axis=2);
arrows(1:6,COV[,ind]-COV.sd[,ind],1:6,COV[,ind]+COV.sd[,ind], length=0.05,angle=90,code=3) 
text(1:6,par("usr")[3], labels = foodlist, srt = 45, adj = c(1.1,1.1), xpd = TRUE, cex=2);
mtext("Food Level",side=1,line=8,cex=2);
text(x=7,y=0.3,"All\nFood",cex=2,xpd=NA,srt=90);
if(printed==T) dev.off()
}
