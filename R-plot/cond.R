cond<-function(GT,colX,colY,shade=F,colplot="black",
	      rangeav,
	      rangeX)
{

	library(ks);

	mydata <- read.table("/home/diana/workspace/data/dataset-add-2/expression5.dat", header=FALSE);

	T2="20";
# Grid size
	GS=50;
# binned
	BinTrue=TRUE;
	BinHpiTrue=TRUE;
# Food list

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
	if(missing(rangeX)) rangeX<-c(minX,maxX);


# Set the color palette
	colpal<-colorRampPalette(c("yellow","red"))(6);
	colpal<-c("black",colpal);

	ind=5;

	Food=2e9;
	data <- subset(data0,(F2==Food|Food==0),select = c(colX,colY))/1e6;
	print(nrow(data));
	H<-Hpi.diag(x=data,binned=BinHpiTrue);
	fhat<-kde(x=data,H=H,xmin=c(minX,minY),xmax=c(maxX,maxY),binned=BinTrue,bgridsize=c(GS,GS),gridsize=GS);
	
	joint=fhat$estimate/sum(fhat$estimate);
	
	condp<-matrix(nrow=GS,ncol=GS);
	
	for(i in 1:GS) {
		condp[i,]<-joint[i,]/max(joint[i,]);
	}


	return(condp);

}


