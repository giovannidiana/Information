library(plotrix)
library(mvtnorm)

nballs=3;
npoints=10000;
colpal=rainbow(nballs,alpha=0.5);
S<-vector("list",length=nballs);
XLIM=c(-3,8);
YLIM=c(-3,7);

for(i in 1:nballs){
	cor=.8+0.*runif(n=1,min=-1,max=1);
	S1=1.+0*rnorm(1,mean=.6,sd=.1)^2;
	S2=1.+0*rnorm(1,mean=.6,sd=.1)^2;
	S[[i]]=matrix(c(S1^2,cor*S1*S2,cor*S1*S2,S2^2),ncol=2,nrow=2);
}

xcenters<-seq(3,nballs-2,length=nballs)+runif(n=nballs,min=-2,max=2);
xcenters<-c(1,2,4);
ycenters<-seq(3,nballs-2,length=nballs)+runif(n=nballs,min=-2,max=2);
ycenters<-c(3,1,2);
pts = vector("list",length=nballs);
for(i in 1:nballs) pts[[i]]=rmvnorm(n=npoints,mean=c(xcenters[i],ycenters[i]),sigma=S[[i]]);

xrange<-seq(from=range(pts)[1],to=range(pts)[2],length.out=npoints);
yrange<-xrange;

layout( matrix( c(1,3,3,1,3,3,0,2,2),ncol=3) )

par(mar=c(0,7,2,0));
plot(xrange,dnorm(xrange,xcenters[1],S[[1]][1,1]),xlim=XLIM, type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[1])
lines(xrange,dnorm(xrange,xcenters[2],S[[2]][1,1]), type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[2])
lines(xrange,dnorm(xrange,xcenters[3],S[[3]][1,1]), type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[3])
par(mar=c(7,0,0,2));


plot(dnorm(yrange,ycenters[1],S[[1]][2,2]),yrange, ylim=YLIM, type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[1])
lines(dnorm(yrange,ycenters[2],S[[2]][2,2]),yrange,type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[2])
lines(dnorm(yrange,ycenters[3],S[[3]][2,2]),yrange,type='l',lwd=2,xaxt="n",yaxt="n",
	xlab="",ylab="",col=colpal[3])
par(mar=c(7,7,0,0));
plot(1:3,1:3,type="n",xaxt="n",yaxt="n",xlim=XLIM,ylim=YLIM,xlab="Neuron 1",ylab="Neuron 2",cex.lab=2);
for(i in 1:nballs) points(pts[[i]],col=colpal[i],pch=".")
points(x=mean(xcenters),y=mean(ycenters),pch=22,cex=3);


