require(abind);
require(RColorBrewer);

tabgt<-vector("list",length=3);
tabvar<-vector("list",length=3);
tabred <- vector("numeric",length=2);
tabred_var <- vector("numeric",length=2);
tabredn <- vector("numeric",length=2);
tabredn_var <- vector("numeric",length=2);

colpal_196<-brewer.pal(n=7,"Greys");
colpal_402<-brewer.pal(n=7,"Reds");
colpal=c(colpal_196[7], colpal_402[7]);

k=0;
for(GTtest in c("QL196","QL402")){
	
	k<-k+1;

	tabInfo_groups <- vector("list",length=5);
	for( i in 1:5) {
		tabInfo_groups[[i]] <- read.table(file=paste(GTtest,"_all_group",i,".dat",sep=""),header=F); 
		tabInfo_groups[[i]] <- rbind(tabInfo_groups[[i]],apply(tabInfo_groups[[i]][2:3,],2,sum)-rep(tabInfo_groups[[i]][1,7],7));
	}
	ab <- abind(tabInfo_groups,along=3);
	tabInfo_var <- apply(ab,1:2,sd);
	tabInfo_mean <- apply(ab,1:2,mean);

	tabgt[[k]]<-tabInfo_mean[1:3,7];
	tabvar[[k]]<-tabInfo_var[1:3,7];
	tabred[k]<-tabInfo_mean[4,7];
	tabred_var[k]<-tabInfo_var[4,7];
	tabredn[k]<-tabred[k]/tabgt[[k]][1];
	tabredn_var[k]<-tabred_var[k]/tabgt[[k]][1];
}

#pdf("Fig1.pdf",height=7,width=3);
layout(matrix(c(1,2,3,4),ncol=1),heights=c(2.5,1.5,1.5,2));
par(mar=c(1.5,6,1.5,2))
tt<-do.call(cbind,tabgt);
tt_var <- do.call(cbind,tabvar);
ttcomb<-cbind(rbind(tt[1,],0,0),rbind(0,tt[2:3,]))[,c(1,3,2,4)];
ttcomb_var<-cbind(rbind(tt_var[1,],0,0),rbind(0,tt_var[2:3,]))[,c(1,3,2,4)];

ttcomb_mod<-matrix(nrow=6,ncol=4)
ttcomb_var_mod<-matrix(nrow=6,ncol=4)
for(i in c(0,2)) {
	ttcomb_mod[,i+1]<-c(rep(0,3*i/2),ttcomb[,i+1],rep(0,3*(1-i/2)));
	ttcomb_mod[,i+2]<-c(rep(0,3*i/2),ttcomb[,i+2],rep(0,3*(1-i/2)));
	ttcomb_var_mod[,i+1]<-c(rep(0,3*i/2),ttcomb_var[,i+1],rep(0,3*(1-i/2)));
	ttcomb_var_mod[,i+2]<-c(rep(0,3*i/2),ttcomb_var[,i+2],rep(0,3*(1-i/2)));
}
pos<-barplot(ttcomb_mod,space=c(.5,.1),
	     ylim=c(0,1.),
	     yaxt='n',
	     ylab="Information (bits)",
	     cex.axis=2,
	     cex.lab=2,
	     col=cbind(colpal_196[c(7,4,5)],colpal_402[c(7,4,5)],colpal_404[c(7,4,5)],colpal_435[c(7,4,5)]));
axis(2,at=c(0,1,2),cex.axis=2);
posmat<-matrix(rep(pos,3),ncol=4,byrow=T);
arrows(posmat,apply(ttcomb,2,cumsum)-ttcomb_var,posmat,apply(ttcomb,2,cumsum)+ttcomb_var, length=0,angle=90,code=3,xpd=T);

pos2<-barplot(tabred,ylim=c(-0.3,.3),
	      ylab="Redundancy",
	      yaxt='n',
	      cex.axis=2,
	      cex.lab=2,
	      col=colpal);
axis(2,at=c(-0.3,0,0.3),cex.axis=2);
arrows(pos2,tabred-tabred_var,pos2,tabred+tabred_var,length=0,angle=90,code=3,xpd=T);

pos3<-barplot(tabredn,ylim=c(-0.3,0.3),
	      ylab="Red./Info.",
	      yaxt='n',
	      cex.axis=2,
	      cex.lab=2,
	      col=colpal);
axis(2,at=c(-0.3,0,0.3),cex.axis=2);
arrows(pos3,tabredn-tabredn_var,pos3,tabredn+tabredn_var,length=0,angle=90,code=3,xpd=T);
par(mar=c(2,6,0,2));
plot(1,type='n',frame=F,axes=F,ylim=c(0,1),xlim=c(-0.1,4.7),xlab="",ylab="");
text(x=pos3,y=rep(1,4),pos=2, labels = c("WT","daf-7(-)"),srt = 60, xpd = T, cex=2);

#dev.off();
