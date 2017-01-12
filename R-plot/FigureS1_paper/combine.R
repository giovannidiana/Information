n=9
tab <-vector("list",n)
GT="QL435"
#GT="QL404"
#GT="QL402"
#GT="QL196"
pdf(paste(GT,"_JK.pdf",sep=""),width=4,height=6,useDingbats=F);
label_list <- seq(60,100,by=5);
info <- vector("numeric",n);
info_range<-c(0.4,1.24);
red <- vector("numeric",n);
red_range<-c(-.2,.4);

for( i in 1:n){
	tab[[i]] <- read.table(paste(GT,"_",label_list[i],"_JKpdf.dat",sep=""),header=F);
	info[i] <- tab[[i]][1,7];
	red[i] <- -tab[[i]][1,7]+tab[[i]][2,7]+tab[[i]][3,7]+tab[[i]][4,7];
}

invl <- 1/label_list
fit_red <- lm(red ~ invl);
fit_inf <- lm(info ~ invl);


layout(matrix(c(1,2),nrow=2));

plot(invl,info,xlab="fraction of data",ylab="Information",xaxt='n',
		main=GT,ylim=info_range,pch=19)
axis(1, at=invl,label=label_list/100)
lines(invl,fit_inf$fitted.values,xlim=c(1,.6));

plot(invl,red,xlab="fraction of data",ylab="Redundancy",xaxt='n',
		ylim=red_range,pch=19)
axis(1, at=invl,label=label_list/100)
lines(invl,fit_red$fitted.values,xlim=c(1,.6));

dev.off();
