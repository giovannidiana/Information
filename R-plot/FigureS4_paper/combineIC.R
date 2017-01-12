require(abind)

# useful function for noise propagation
R.noise <- function(x,y,z,x.sd,y.sd,z.sd){
	    # x.sd : SD on the correlation
	    
	    w=x.sd^2/(y*z)+1/4*x^2/(z*y)*(y.sd^2/y^2+z.sd^2/z^2);

	    sqrt(w)
}

Print2DInfos <- function(GTtest,XY,printed=F){

if(printed==T) pdf(paste(GTtest,"_",XY,".pdf",sep=""));

foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10,"All food");

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


layout(matrix(c(1,2),ncol=1),heights=c(2,4))
par(mar=c(0,2,1,2))
plot.new()
tit=
legend("left",legend=c(tit,Xlab,Ylab),fill=c("orange","red","yellow"),cex=2)
legend("right",legend=c("Redundancy"),fill=c("purple"),cex=2)

par(mar=c(2,5,2,2))
pos<-barplot(as.matrix(tabInfo),beside=T,cex.axis=2,
		ylab="Information (bits)",xaxt="n",cex.lab=2,
		col=c("orange","red","yellow","purple"));
arrows(pos,as.matrix(tabInfo)-tabInfo_var,pos,as.matrix(tabInfo)+tabInfo_var, length=0.05,angle=90,code=3,xpd=T);
if(printed==T) dev.off()
}
