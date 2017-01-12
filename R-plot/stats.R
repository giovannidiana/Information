fun<-function(GT,colX,colY,shade=F,colplot="black",
	      foodindex=0:6,
	      rangeav,
	      rangevar,
	      rangeX)
{

	library(ks);
#mydata <- read.table("/home/diana/workspace/data/data-June_WT/Gfile.dat", header=FALSE);

	mydata <- read.table("/home/diana/workspace/data/dataset-add-2/expression5.dat", header=FALSE);

	T2="20";
# Grid size
	GS=150;
# binned
	BinTrue=TRUE;
	BinHpiTrue=TRUE;
# Food list
	foodlist=c(0,1,2e7,6.3e7,6.3e8,2e9,1.1e10);
	foodstring=c("All food levels","S basal","2.00E+06","6.30E+07","6.30E+08","2.00E+09","1.10E+10");

	data0 <- subset(mydata,V3==GT & V6==T2 & V4==6);
	print(nrow(data0));
# Make grid
	names(data0)<-c("B","BD","GT","Day","F2","T2","ADF","ASI","NSM");
	
	minX=min(data0[,c(colX)])/1e6;
	minY=min(data0[,c(colY)])/1e6;
	maxX=max(data0[,c(colX)])/1e6;
	maxY=max(data0[,c(colY)])/1e6;

	X_vec=seq(minX,maxX,length.out=GS);
	Y_vec=seq(minY,maxY,length.out=GS);
	Y2_vec=Y_vec^2;

# Construct the rectangles
	left=X_vec[1:GS-1];
	right=X_vec[2:GS];
	bottom=rep(-20,GS-1);
	top=rep(300,GS-1);
	
	if(missing(rangeav)) rangeav<-c(minY,maxY);
	if(missing(rangevar)) rangevar<-c(0,maxY);
	if(missing(rangeX)) rangeX<-c(minX,maxX);


# Set the color palette
	colpal<-colorRampPalette(c("yellow","red"))(6);
	colpal<-c("black",colpal);
	mean<-vector("list",7);
	var<-vector("list",7);
	prob<-vector("list",7);

	for(ind in foodindex){
		Food=foodlist[ind+1];
		data <- subset(data0,(F2==Food|Food==0),select = c(colX,colY))/1e6;
		print(nrow(data));
		H<-Hpi.diag(x=data,binned=BinHpiTrue);
		fhat<-kde(x=data,H=H,xmin=c(minX,minY),xmax=c(maxX,maxY),binned=BinTrue,bgridsize=c(GS,GS),gridsize=GS);

		joint=fhat$estimate/sum(fhat$estimate);

		mean[[ind+1]]<-vector(mode="numeric",len=GS);
		var[[ind+1]]<-vector(mode="numeric",len=GS);
		prob[[ind+1]]<-vector(mode="numeric",len=GS);

		for(i in 1:GS) {
			mean[[ind+1]][i]=Y_vec %*% joint[i,]/sum(joint[i,]);
			var[[ind+1]][i]=Y2_vec %*% joint[i,]/sum(joint[i,]);
			prob[[ind+1]][i]= sum(joint[i,]);
		}
		var[[ind+1]]=var[[ind+1]]-mean[[ind+1]]^2;
	}
# Prepare the two screens


##  Set the outer margins so that bottom, left, and right are 0
##  and top is 3 lines of text.

	par( oma = c( 0, 0, 5, 0 ) )

        par(mfrow=c(1,2));

# Plot on the first screen

	plot(rangeX,rangeav,
	     type="n",
	     xlab=colX,
	     ylab=paste("Average",colY));
	

	for(ind in foodindex){
		
		if(shade&ind==0){
			rect(left,bottom,right,top,border=F,
			     col=rgb(colorRamp(c("black","white"))(prob[[ind+1]]/max(prob[[ind+1]])),
		                     maxColorValue=255,alpha=100)
			);
		}

		lines(X_vec,mean[[ind+1]],lwd=3,lty=ind+1,col=colpal[ind+1]);
	}

# Plot on the second screen

	plot(rangeX,rangevar,
             type="n",
	     xlab=colX,
	     ylab=paste("Variance",colY));

	for(ind in foodindex){

		if(shade&ind==0){
			rect(left,bottom,right,top,border=F,
			     col=rgb(colorRamp(c("black","white"))(prob[[ind+1]]/max(prob[[ind+1]])),
				     maxColorValue=255,alpha=100)
			);
		}
		
		lines(X_vec,var[[ind+1]],lwd=3,lty=ind+1,col=colpal[ind+1]);

	}

	title(paste("Genotype",GT),outer=TRUE,line=2);
	legend("topright",foodstring,lty=1:7,lwd=3,col=colpal);







## THIS ADD A PLOT OF THE COLOR SCALE
#screen(3);
#nr=GS-1;
#plot(0:nr/nr,prob,yaxt="n",col="white",
#     xlab=paste("Color scale - P(",colX,")",sep=""),
#     ylab="",
#     frame.plot=F);
#rect((0:(nr-1))/nr,rep(0,GS-1),1:nr/nr,rep(10,nr),border=F,col=rgb(colorRamp(c("red","white"))(0:nr/nr),maxColorValue=255,alpha=100));
#
}

fun2<-function(GT,colX,colY,shade=F,colplot="black",
	      foodindex=0:6,
	      rangeav,
	      rangevar,
	      rangeX)
{

	library(ks);
#mydata <- read.table("/home/diana/workspace/data/data-June_WT/Gfile.dat", header=FALSE);

	mydata <- read.table("/home/diana/workspace/data/dataset-add-2/expression5.dat", header=FALSE);

	T2="20";
# Grid size
	GS=150;
# binned
	BinTrue=TRUE;
	BinHpiTrue=TRUE;
# Food list
	foodlist=c(0,1,2e7,6.3e7,6.3e8,2e9,1.1e10);
	foodstring=c("All food levels","S basal","2.00E+06","6.30E+07","6.30E+08","2.00E+09","1.10E+10");

	data0 <- subset(mydata,V3==GT & V6==T2 & V4==6);
	print(nrow(data0));
# Make grid
	names(data0)<-c("B","BD","GT","Day","F2","T2","ADF","ASI","NSM");
	
	minX=min(data0[,c(colX)])/1e6;
	minY=min(data0[,c(colY)])/1e6;
	maxX=max(data0[,c(colX)])/1e6;
	maxY=max(data0[,c(colY)])/1e6;

	X_vec=seq(minX,maxX,length.out=GS);
	Y_vec=seq(minY,maxY,length.out=GS);
	Y2_vec=Y_vec^2;

# Construct the rectangles
	left=X_vec[1:GS-1];
	right=X_vec[2:GS];
	bottom=rep(-20,GS-1);
	top=rep(300,GS-1);
	
	if(missing(rangeav)) rangeav<-c(minY,maxY);
	if(missing(rangevar)) rangevar<-c(0,maxY);
	if(missing(rangeX)) rangeX<-c(minX,maxX);


# Set the color palette
	colpal<-colorRampPalette(c("yellow","red"))(6);
	colpal<-c("black",colpal);
	mean<-vector("list",7);
	var<-vector("list",7);
	prob<-vector("list",7);
	fano<-vector("list",7);

# Definition of variables related to the dynamic ranges on averages
# and fano factor. I initialise minM and maxM with maxY and minY respectively
# according to the algorithm below to find the minimum and maximum of the 
# average and the fano factor for which the prob is larger than a threshold
	minM<-rep(10e9,7);
	maxM<-rep(0,7);
	minF<-rep(100,7);
	maxF<-rep(0,7);
	
	dr<-matrix(nrow=2,ncol=7);
	
# ----------------------------

	for(ind in foodindex){
		Food=foodlist[ind+1];
		data <- subset(data0,(F2==Food|Food==0),select = c(colX,colY))/1e6;
		print(nrow(data));
		H<-Hpi.diag(x=data,binned=BinHpiTrue);
		fhat<-kde(x=data,H=H,xmin=c(minX,minY),xmax=c(maxX,maxY),binned=BinTrue,bgridsize=c(GS,GS),gridsize=GS);

		joint=fhat$estimate/sum(fhat$estimate);

		mean[[ind+1]]<-vector(mode="numeric",len=GS);
		var[[ind+1]]<-vector(mode="numeric",len=GS);
		prob[[ind+1]]<-vector(mode="numeric",len=GS);
		fano[[ind+1]]<-vector(mode="numeric",len=GS);

		for(i in 1:GS) {
			mean[[ind+1]][i]=Y_vec %*% joint[i,]/sum(joint[i,]);
			var[[ind+1]][i]=Y2_vec %*% joint[i,]/sum(joint[i,])-mean[[ind+1]][i]^2;
			prob[[ind+1]][i]= sum(joint[i,]);
			fano[[ind+1]][i]= mean[[ind+1]][i]/sqrt(var[[ind+1]][i]);
			if(prob[[ind+1]][i]>0.5*max(prob[[ind+1]])) {
				if(mean[[ind+1]][i]<minM[ind+1]) minM[ind+1]=mean[[ind+1]][i];
				if(mean[[ind+1]][i]>maxM[ind+1]) maxM[ind+1]=mean[[ind+1]][i];
				if(fano[[ind+1]][i]<minF[ind+1]) minF[ind+1]=fano[[ind+1]][i];
				if(fano[[ind+1]][i]>maxF[ind+1]) maxF[ind+1]=fano[[ind+1]][i];
			}
		}

		dr[1,ind+1]=(maxM[ind+1]-minM[ind+1])/maxM[ind+1];
		if(dr[1,ind+1]>1) print(paste(GT,ind+1,minM[ind+1],maxM[ind+1]));
		dr[2,ind+1]=(maxF[ind+1]-minF[ind+1])/maxF[ind+1];
	}

# Prepare the two screens


##  Set the outer margins so that bottom, left, and right are 0
##  and top is 3 lines of text.

	par( oma = c( 0, 0, 5, 0 ) )

        par(mfrow=c(1,2));

# Plot on the first screen

	plot(rangeX,rangeav,
	     type="n",
	     xlab=colX,
	     ylab=paste("Average",colY));
	

	for(ind in foodindex){
		
		if(shade&ind==0){
			rect(left,bottom,right,top,border=F,
			     col=rgb(colorRamp(c("black","white"))(prob[[ind+1]]/max(prob[[ind+1]])),
		                     maxColorValue=255,alpha=100)
			);
		}

		lines(X_vec,fano[[ind+1]],lwd=3,lty=ind+1,col=colpal[ind+1]);
	}
	
	legend("topright",foodstring,lty=1:7,lwd=3,col=colpal);

# Plot on the second screen


	colnames(dr)<-c("All","S basal","2.0E+07","6.3E+07","6.3E+08","2.0E+09","1.10E+10");
	print(paste(GT,colX,colY,ind+1,minM[ind+1],maxM[ind+1]));
	print(dr);


	barplot(dr,
		ylab="dynamic range",
		xlab="Food condition",
		col=c("red","blue"),
		beside=TRUE
		);

	legend("topright",c("Mean","Mean/RMS"),cex=1.3,bty="n",fill=c("red","blue"));
		
	title(paste("Genotype",GT),outer=TRUE,line=2);







## THIS ADD A PLOT OF THE COLOR SCALE
#screen(3);
#nr=GS-1;
#plot(0:nr/nr,prob,yaxt="n",col="white",
#     xlab=paste("Color scale - P(",colX,")",sep=""),
#     ylab="",
#     frame.plot=F);
#rect((0:(nr-1))/nr,rep(0,GS-1),1:nr/nr,rep(10,nr),border=F,col=rgb(colorRamp(c("red","white"))(0:nr/nr),maxColorValue=255,alpha=100));
#
}

funDR<-function(GT,colX,colY,shade=F,colplot="black",
	      foodindex=0:6,
	      rangeav,
	      rangevar,
	      rangeX)
{

	library(ks);
#mydata <- read.table("/home/diana/workspace/data/data-June_WT/Gfile.dat", header=FALSE);

	mydata <- read.table("/home/diana/workspace/data/dataset-add-2/expression5.dat", header=FALSE);

	T2="20";
# Grid size
	GS=150;
# binned
	BinTrue=TRUE;
	BinHpiTrue=TRUE;
# Food list
	foodlist=c(0,1,2e7,6.3e7,6.3e8,2e9,1.1e10);
	foodstring=c("All food levels","S basal","2.00E+06","6.30E+07","6.30E+08","2.00E+09","1.10E+10");

	data0 <- subset(mydata,V3==GT & V6==T2 & V4==6);
	print(nrow(data0));
# Make grid
	names(data0)<-c("B","BD","GT","Day","F2","T2","ADF","ASI","NSM");
	
	minX=min(data0[,c(colX)])/1e6;
	minY=min(data0[,c(colY)])/1e6;
	maxX=max(data0[,c(colX)])/1e6;
	maxY=max(data0[,c(colY)])/1e6;

	X_vec=seq(minX,maxX,length.out=GS);
	Y_vec=seq(minY,maxY,length.out=GS);
	Y2_vec=Y_vec^2;

# Construct the rectangles
	left=X_vec[1:GS-1];
	right=X_vec[2:GS];
	bottom=rep(-20,GS-1);
	top=rep(300,GS-1);
	
	if(missing(rangeav)) rangeav<-c(minY,maxY);
	if(missing(rangevar)) rangevar<-c(0,maxY);
	if(missing(rangeX)) rangeX<-c(minX,maxX);


# Set the color palette
	colpal<-colorRampPalette(c("yellow","red"))(6);
	colpal<-c("black",colpal);
	mean<-vector("list",7);
	var<-vector("list",7);
	prob<-vector("list",7);

	for(ind in foodindex){
		Food=foodlist[ind+1];
		data <- subset(data0,(F2==Food|Food==0),select = c(colX,colY))/1e6;
		print(nrow(data));
		H<-Hpi.diag(x=data,binned=BinHpiTrue);
		fhat<-kde(x=data,H=H,xmin=c(minX,minY),xmax=c(maxX,maxY),binned=BinTrue,bgridsize=c(GS,GS),gridsize=GS);

		joint=fhat$estimate/sum(fhat$estimate);

		mean[[ind+1]]<-vector(mode="numeric",len=GS);
		var[[ind+1]]<-vector(mode="numeric",len=GS);
		prob[[ind+1]]<-vector(mode="numeric",len=GS);

		for(i in 1:GS) {
			mean[[ind+1]][i]=Y_vec %*% joint[i,]/sum(joint[i,]);
			var[[ind+1]][i]=Y2_vec %*% joint[i,]/sum(joint[i,]);
			prob[[ind+1]][i]= sum(joint[i,]);
		}
		var[[ind+1]]=var[[ind+1]]-mean[[ind+1]]^2;
	}

	
# Prepare the first screen for plot

	plot(rangeX,rangeav,
	     type="n",
	     xlab=colX,
	     ylab=paste("Average",colY));

	for(ind in foodindex){
		
		if(shade&ind==0){
			rect(left,bottom,right,top,border=F,
			     col=rgb(colorRamp(c("black","white"))(prob[[ind+1]]/max(prob[[ind+1]])),
		                     maxColorValue=255,alpha=100)
			);
		}

		lines(X_vec,mean[[ind+1]]/sqrt(var[[ind+1]]),lwd=3,lty=ind+1,col=colpal[ind+1]);
	}

	legend("topright",foodstring,lty=1:7,lwd=3,col=colpal);

# Plot on the second screen

	title(paste("Genotype",GT),outer=TRUE,line=2);

## THIS ADD A PLOT OF THE COLOR SCALE
#screen(3);
#nr=GS-1;
#plot(0:nr/nr,prob,yaxt="n",col="white",
#     xlab=paste("Color scale - P(",colX,")",sep=""),
#     ylab="",
#     frame.plot=F);
#rect((0:(nr-1))/nr,rep(0,GS-1),1:nr/nr,rep(10,nr),border=F,col=rgb(colorRamp(c("red","white"))(0:nr/nr),maxColorValue=255,alpha=100));
#
}
