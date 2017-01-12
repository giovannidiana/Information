Ivec<-read.table("I.dat")$V7
I1vec<-read.table("I1.dat")$V7
I2vec<-read.table("I2.dat")$V7
I3vec<-read.table("I3.dat")$V7

Rvec<-I1vec+I2vec+I3vec-Ivec


