#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include"func.h"

using namespace std;

double MInfo(double* joint,int gridsize){

	ifstream infile;
	int i,l,j,k;
	double Info=0;

	//ifstream infile("/home/diana/workspace/Analysis/R_projects/pdf12_QL435_ALL.dat");

	//double joint[gridsize][gridsize];
	double margX[gridsize];
	double margY[gridsize];

	for(j=0;j<gridsize;j++){
		margX[j]=0;
		margY[j]=0;
	}

	for(j=0;j<gridsize;j++){
		for(k=0;k<gridsize;k++){
			//infile>>joint[j][k];
			margX[j]+=joint[j*gridsize+k];
			margY[k]+=joint[j*gridsize+k];
		}
	}

	for(j=0;j<gridsize;j++){
		for(k=0;k<gridsize;k++){
			if(joint[j*gridsize+k]!=0) Info+=joint[j*gridsize+k]*log(joint[j*gridsize+k]/(margX[j]*margY[k]))/log(2.);
		}
	}

	return Info;



}

double MInfo2(double* cond,double* input, int gridsize,int Nin){

	
	int i,l,j,k;
	double Info=0;

	double marg[gridsize];

	for(j=0;j<gridsize;j++){
		marg[j]=0;
	}

	for(j=0;j<gridsize;j++){
		for(k=0;k<Nin;k++){
			if(cond[k*gridsize+j]>0) marg[j]+=input[k]*cond[k*gridsize+j];
		}
	}

	for(j=0;j<gridsize;j++){
		for(k=0;k<Nin;k++){
			if(cond[k*gridsize+j]>0) Info+=input[k]*cond[k*gridsize+j]*log(cond[k*gridsize+j]/marg[j])/log(2.);			
		}
	}

	return Info;

}

void MInfo_vec(double* cond,double* input, int gridsize,int Nin,double* infovec){

	
	int i,l,j,k;

	double marg[gridsize];

	for(j=0;j<gridsize;j++){
		marg[j]=0;
	}

	for(i=0;i<Nin;i++) infovec[i]=0;

	for(j=0;j<gridsize;j++){
		for(k=0;k<Nin;k++){
			if(cond[k*gridsize+j]>0) marg[j]+=input[k]*cond[k*gridsize+j];
		}
	}

	for(j=0;j<gridsize;j++){
		for(k=0;k<Nin;k++){
			if(cond[k*gridsize+j]>0) infovec[k]+=/*input[k]**/cond[k*gridsize+j]*log(cond[k*gridsize+j]/marg[j])/log(2.);
		}
	}

}
