source("stats.R");

pdf("ratio_QL196_21.pdf",width=12,height=6);
fun2("QL196","ASI","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,7),rangeX=c(10,30));
dev.off()

pdf("ratio_QL196_12.pdf",width=12,height=7)
fun2("QL196","ADF","ASI",shade=T,rangeav=c(0,5),rangevar=c(10,75),rangeX=c(11,15));
dev.off();

pdf("ratio_QL196_13.pdf",width=12,height=7);
fun2("QL196","ADF","NSM",shade=T,rangeav=c(0,18),rangevar=c(5,35),rangeX=c(11,15));
dev.off();

pdf("ratio_QL196_31.pdf",width=12,height=7);
fun2("QL196","NSM","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,6.5),rangeX=c(38,53));
dev.off();

pdf("ratio_QL196_23.pdf",width=12,height=7);
fun2("QL196","ASI","NSM",shade=T,rangeav=c(0,18),rangevar=c(5,45),rangeX=c(10,30));
dev.off();

pdf("ratio_QL196_32.pdf",width=12,height=7);
fun2("QL196","NSM","ASI",shade=T,rangeav=c(0,5),rangevar=c(10,90),rangeX=c(38,53));
dev.off();

### QL404

pdf("ratio_QL404_21.pdf",width=12,height=6);
fun2("QL404","ASI","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,7),rangeX=c(10,30));
dev.off()

pdf("ratio_QL404_12.pdf",width=12,height=7)
fun2("QL404","ADF","ASI",shade=T,rangeav=c(0,18),rangevar=c(10,75),rangeX=c(11,15));
dev.off();

pdf("ratio_QL404_13.pdf",width=12,height=7);
fun2("QL404","ADF","NSM",shade=T,rangeav=c(0,18),rangevar=c(5,35),rangeX=c(11,15));
dev.off();

pdf("ratio_QL404_31.pdf",width=12,height=7);
fun2("QL404","NSM","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,6.5),rangeX=c(38,53));
dev.off();

pdf("ratio_QL404_23.pdf",width=12,height=7);
fun2("QL404","ASI","NSM",shade=T,rangeav=c(0,18),rangevar=c(5,45),rangeX=c(10,30));
dev.off();

pdf("ratio_QL404_32.pdf",width=12,height=7);
fun2("QL404","NSM","ASI",shade=T,rangeav=c(0,18),rangevar=c(10,90),rangeX=c(38,53));
dev.off();

### QL402

pdf("ratio_QL402_21.pdf",width=12,height=6);
fun2("QL402","ASI","ADF",shade=T,rangeav=c(0,18),rangevar=c(4,35),rangeX=c(10,30));
dev.off()

pdf("ratio_QL402_12.pdf",width=12,height=7)
fun2("QL402","ADF","ASI",shade=T,rangeav=c(0,18),rangevar=c(10,75),rangeX=c(12,22));
dev.off();

pdf("ratio_QL402_13.pdf",width=12,height=7);
fun2("QL402","ADF","NSM",shade=T,rangeav=c(0,18),rangevar=c(30,110),rangeX=c(12,22));
dev.off();

pdf("ratio_QL402_31.pdf",width=12,height=7);
fun2("QL402","NSM","ADF",shade=T,rangeav=c(0,18),rangevar=c(4,35),rangeX=c(35,60));
dev.off();

pdf("ratio_QL402_23.pdf",width=12,height=7);
fun2("QL402","ASI","NSM",shade=T,rangeav=c(0,18),rangevar=c(30,150),rangeX=c(10,30));
dev.off();

pdf("ratio_QL402_32.pdf",width=12,height=7);
fun2("QL402","NSM","ASI",shade=T,rangeav=c(0,18),rangevar=c(10,90),rangeX=c(38,53));
dev.off();

### QL435

pdf("ratio_QL435_21.pdf",width=12,height=6);
fun2("QL435","ASI","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,20),rangeX=c(5,15));
dev.off()

pdf("ratio_QL435_12.pdf",width=12,height=7)
fun2("QL435","ADF","ASI",shade=T,rangeav=c(0,18),rangevar=c(5,70),rangeX=c(12,20));
dev.off();

pdf("ratio_QL435_13.pdf",width=12,height=7);
fun2("QL435","ADF","NSM",shade=T,rangeav=c(0,18),rangevar=c(30,180),rangeX=c(12,20));
dev.off();

pdf("ratio_QL435_31.pdf",width=12,height=7);
fun2("QL435","NSM","ADF",shade=T,rangeav=c(0,18),rangevar=c(0,30),rangeX=c(40,70));
dev.off();

pdf("ratio_QL435_23.pdf",width=12,height=7);
fun2("QL435","ASI","NSM",shade=T,rangeav=c(0,18),rangevar=c(30,180),rangeX=c(5,15));
dev.off();

pdf("ratio_QL435_32.pdf",width=12,height=7);
fun2("QL435","NSM","ASI",shade=T,rangeav=c(0,18),rangevar=c(5,70),rangeX=c(40,70));
dev.off();



