
pdf196<-c(0.447823, 1.23438e-127, 3.01869e-68, 0.346158, 4.28946e-21, 0.20602);
pdf404<-c(0.389131, 0.0233961, 1.50518e-13, 0.327774, 5.05232e-08, 0.2597)
pdf402<-c(0.177805, 0.22745, 0.00015111, 0.258977, 0.0445254, 0.291091)
pdf435<-c(0.403121, 0.03592, 0.0350744, 0.311838, 0.000184441, 0.213861);

info<-c(0.881731,1.16645,0.390971,0.681934);
names(info)=c("WT","tph-1(-)","daf-7(-)","tph-1(-);daf-7(-)")
foodlist = expression("S basal", 2%.%10^7, 6.3%.%10^7, 6.3%.%10^8, 2%.%10^9, 1.1%.%10^10);

#X11(width=12,height=3)
pdf("input_dists.pdf",width=12,height=3)
layout(matrix(c(1,2,3,4),nrow=1),heights=c(4,4,4,4));
par(mar=c(10,5,2,3));
barplot(pdf196,	main=names(info)[1],cex.main=2,cex.axis=2,ylim=c(0,.5),
		ylab="P(Food)",cex.lab=2,xlab="");
mtext("Food",side=1,line=8,cex=1.5);
text(seq(0.5,6.5,length=6),par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
barplot(pdf404,	main=names(info)[2],cex.main=2,cex.axis=2,ylim=c(0,.5),
		ylab="P(Food)",cex.lab=2);
mtext("Food",side=1,line=8,cex=1.5);
text(seq(0.5,6.5,length=6),par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
barplot(pdf402,	main=names(info)[3],cex.main=2,cex.axis=2,ylim=c(0,.5),
		ylab="P(Food)",cex.lab=2);
mtext("Food",side=1,line=8,cex=1.5);
text(seq(0.5,6.5,length=6),par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
barplot(pdf435,	main=names(info)[4],cex.main=2,cex.axis=2,ylim=c(0,.5),
		ylab="P(Food)",cex.lab=2);
mtext("Food",side=1,line=8,cex=1.5);
text(seq(0.5,6.5,length=6),par("usr")[3], labels = foodlist, srt = 60, adj = c(1.1,1.1), xpd = TRUE, cex=2);
dev.off();

#X11()
pdf("optimal2.pdf")
par(mar=c(8,6,2,3));
barplot(info,
	ylab="Channel Capacity (Bits)",cex.lab=2,cex.names=2,cex.axis=2,
	col=c("black","blue","red","purple"),xlab="Genotype")

dev.off()
