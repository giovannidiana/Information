#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include<cstring>
#include<stdlib.h>
#include<gmp.h>
//#include"func.h"

using namespace std;

int main(int argc,char** argv){

	// argv[1] = Genotype
	// argv[2] = pdf folder
	// argv[3] = label
	// argv[4] = gridsize
	// argv[5] = group

	if(argc==1) {
		cout<<"-------------------------------------"<<endl;
		cout<<"2D Channel Capacity Calculator"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <folder name> <label> <gridsize> <group>"<<endl;
		exit(0);
	}


	ifstream infile[6];
	const int gridsize=atoi(argv[4]);
	const int group=atoi(argv[5]);
	int i,l,j,k,l1;
	int counter=0;
	double Z=0;

        stringstream filename;

	string foodlist[6] = {"1", "2e+07", "6.3e+07", "6.3e+08", "2e+09", "1.1e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		filename<<argv[2]<<"/"<<argv[3]<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<group<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	ofstream outfile_info("info.dat");

	double joint[6][gridsize][gridsize];

	for(j=0;j<gridsize;j++){
		for(k=0;k<gridsize;k++){
			for(i=0;i<6;i++){
				infile[i]>>joint[i][j][k];
				if(joint[i][j][k]==0) joint[i][j][k]=1e-12;
			}
		}
	}
	
// NORMALIZATION
	for(k=0;k<6;k++){
		Z=0;
		for(i=0;i<gridsize;i++){
		for(j=0;j<gridsize;j++){
			Z+=joint[k][i][j];
		}
		}

		for(i=0;i<gridsize;i++){
		for(j=0;j<gridsize;j++){
			joint[k][i][j]/=Z;
		}
		}
	}



	double input_pdf[6];
	int exp_vec[6];
	double pg=0;
	double pcg[6];
	double logsum[6];
	double Info=0;
	int index=0;
	//double input_pdf_402help[6] = {0.071355759, 0.183486239, 0.001019368, 0.244648318, 0.438328236, 0.061162080};
	double input_pdf_404help[6] = {0.4, 0.08, 0.01, 0.29, 0.02, 0.2};

	while(counter<1000){
		
		if(counter==0) {
			for(i=0;i<6;i++) {
				input_pdf[i]=1/6.;
				if(strcmp(argv[1],"QL404")==0){
					input_pdf[i]=input_pdf_404help[i];
				}

				exp_vec[i]=0;
			}
		}

		counter++;

		for(i=0;i<6;i++) logsum[i]=0;

	    	for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				pg=0;
				for(i=0;i<6;i++) pg += joint[i][j][k]*input_pdf[i];
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


		for(i=0;i<6;i++) {
			input_pdf[i]=input_pdf[i]/Z;
		}	
			
		
		Info=0;
	    	for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				for(i=0;i<6;i++){
					pg=0; for(l1=0;l1<6;l1++) pg+=joint[l1][j][k]*input_pdf[l1];
					if(joint[i][j][k]>0) Info+=input_pdf[i]*joint[i][j][k]*log(joint[i][j][k]/pg)/log(2.);
				}				
			}
		}
		
	        for(i=0;i<6;i++) outfile_info<<input_pdf[i]<<' ';
		outfile_info<<Info<<endl;



	}

	for(i=0;i<6;i++) cout<<input_pdf[i]<<' ';
	cout<<Info<<endl;

}


					



