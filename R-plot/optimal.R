pdf("optimal.pdf",width=8,height=12)
#dev.new(width=8, height=12)

pdf196<-c(0.447823, 1.23438e-127, 3.01869e-68, 0.346158, 4.28946e-21, 0.20602);
pdf404<-c(0.389131, 0.0233961, 1.50518e-13, 0.327774, 5.05232e-08, 0.2597)
pdf402<-c(0.177805, 0.22745, 0.00015111, 0.258977, 0.0445254, 0.291091)
pdf435<-c(0.403121, 0.03592, 0.0350744, 0.311838, 0.000184441, 0.213861);

info<-c(0.881731,1.16645,0.390971,0.681934);
names(info)=c("QL196","QL404","QL402","QL435")


split.screen( figs = c(2,1) );

split.screen( figs = c( 2, 2 ), screen=1 );
split.screen( figs = c( 1, 1 ), screen=2 );

screen(3);
barplot(pdf196,	main="QL196");
screen(4);
barplot(pdf404,	main="QL404");
screen(5);
barplot(pdf402,	main="QL402");
screen(6);
barplot(pdf435,	main="QL435");

screen(2);
barplot(info,
	main="Channel Capacity",
	col=c("black","blue","red","purple"))

dev.off()
