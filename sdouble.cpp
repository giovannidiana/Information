
#include<iostream>
#include"fun.h"

using namespace std;


sdouble::sdouble(){
	fpart=0;
	epart=0;
}

sdouble::sdouble(double d,int e){
	fpart=d;
	epart=e;
}

sdouble::slog(){
	return log(fpart)+epart*log(10);
}

void sdouble::set(double x){
	int i=0;
	double y=x;
	while(fabs(y)>10){
		y=y/10;
		i++;
	}
	fpart=y;
	epart=i;
}

sdouble operator+(const sdouble &param){
	sdouble temp;
	int comm_e=1;
	double sum1,sum2;

	if(param.epart==epart){
		sum1=param.fpart+fpart;
		if(fabs(sum1)<10){
			temp.epart=epart;
			temp.fpart=fpart+param.fpart;
			return temp;
		} else {
			temp.epart=epart+1;
			temp.fpart
	} else if(epart>param.epart){
		sum1=fpart*pow(10,epart-param.epart)+param.epart;
		sum2=sum1/pow(10,epart-param.epart);
		if(fabs(sum2)<10) temp.fpart=sum2; temp.epart=epart;
		if(fabs(sum2)>10


	
		


		sdouble operator+(const sdouble&);
		set(double);
}
		
	       

