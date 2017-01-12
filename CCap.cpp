#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include<string>
#include<stdlib.h>
#include"func.h"

using namespace std;

int main(int argc,char** argv){

	// argv[1] = Genotype
	// argv[2] = 12, 23 or 13
	// argv[3] = pdf folder
	// argv[4] = gridsize

	if(argc==1) {
		cout<<"-------------------------------------"<<endl;
		cout<<"Bivariate Channel Capacity Calculator"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <XY> <folder name> <gridsize> <seed>"<<endl;
		exit(0);
	}


	ifstream infile[6];
	const int gridsize=atoi(argv[4]);
	const int seed=atoi(argv[5]);
	int i,l,j,k;
	int counter=0;

        stringstream filename;
	stringstream infile_ALL_name;

	string foodlist[6] = {"1", "2e+07", "6.3e+07", "6.3e+08", "2e+09", "1.1e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		filename<<argv[3]<<"/pdfR"<<argv[2]<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_s"<<seed<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	infile_ALL_name<<"/home/diana/workspace/Analysis/R_projects/"<<argv[3]<<"/pdfR"<<argv[2]<<'_'<<argv[1]<<"_0_GS"<<gridsize<<"_s"<<seed<<".dat";
	ifstream infile_ALL(infile_ALL_name.str().c_str());

	ofstream outfile_info("info.dat");


	double joint[6][gridsize][gridsize];
	double joint_ALL[gridsize][gridsize];

	for(i=0;i<6;i++){
		for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				infile[i]>>joint[i][j][k];
			}
		}
	}

	
	for(j=0;j<gridsize;j++){
		for(k=0;k<gridsize;k++){
			infile_ALL>>joint_ALL[j][k];
		}
	}

	double input_pdf[6];
	double pg=0;
	double pcg[6];
	double logsum[6];
	double Z=0;
	double Info=0;

	while(counter<1000){
		
		if(counter==0) {
			for(i=0;i<6;i++) {
				input_pdf[i]=1/6.;
			}
		}

		counter++;

		for(i=0;i<6;i++) logsum[i]=0;

	    	for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				pg=0;
				for(i=0;i<6;i++) pg+=joint[i][j][k]*input_pdf[i];
				for(i=0;i<6;i++) pcg[i]=joint[i][j][k]*input_pdf[i]/pg;
				for(i=0;i<6;i++) {
					if(joint[i][j][k]!=0) logsum[i]+=joint[i][j][k]*log(pcg[i]);
				}
			}
		}

		Z=0;
		for(i=0;i<6;i++) {
			input_pdf[i]=exp(logsum[i]);
			Z+=input_pdf[i];
		}

		for(i=0;i<6;i++) input_pdf[i]/=Z;
		
		Info=0;
	    	for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				for(i=0;i<6;i++){
					pg=0; for(l=0;l<6;l++) pg+=joint[l][j][k]*input_pdf[l];
					if(joint[i][j][k]!=0) Info+=input_pdf[i]*joint[i][j][k]*log(joint[i][j][k]/pg)/log(2.);
				}
			}
		}
		
		outfile_info<<Info<<endl;



	}

	for(i=0;i<6;i++) cout<<input_pdf[i]<<' ';
	cout<<Info<<' '<<MInfo((double*)joint_ALL,gridsize)<<' '<<gridsize<<endl;

}


					



