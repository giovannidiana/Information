#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include<string>
#include<stdlib.h>

using namespace std;

int main(int argc,char** argv){

	// argv[1] = genotype
	// argv[2] = folder
	// argv[3] = gridsize
	// argv[4] = group

	if(argc<5) {
		cout<<"-------------------------------------"<<endl;
		cout<<"1D Channel Capacity Calculator"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <folder name> <gridsize> <group>"<<endl;
		exit(0);
	}


	ifstream infile[6];
	ofstream outp("inpdfLS.dat");
	const int gridsize=atoi(argv[3]);
	int i,l,j,k;
	int counter=0;

        stringstream filename;

	string foodlist[6] = {"1.00e+00", "2.00e+07", "6.32e+07", "6.32e+08", "2.00e+09", "1.12e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		filename<<argv[2]<<"/pdf_LS"<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<argv[4]<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	ofstream outfile_info("info_LS.dat");
	ofstream outfile_bdbyfood("bdbyfood_LS.dat");

	double joint[6][gridsize];

	for(i=0;i<6;i++){
		for(j=0;j<gridsize;j++){
			infile[i]>>joint[i][j];
		}
	}

	double input_pdf[6];
	double Info_vec[6];
	double pg=0;
	double pcg[6];
	double logsum[6];
	double Z=0;
	double Info=0;

	while(counter<2000){
		
		if(counter==0) {
			for(i=0;i<6;i++) {
				input_pdf[i]=1/6.;
			}
		}

		counter++;

		for(i=0;i<6;i++) {
			logsum[i]=0;
			Info_vec[i]=0;
		}

	    	for(j=0;j<gridsize;j++){
			pg=0;
			for(i=0;i<6;i++) if(joint[i][j]>0) pg+=joint[i][j]*input_pdf[i];
			for(i=0;i<6;i++) {
				if(joint[i][j]>0) pcg[i]=joint[i][j]*input_pdf[i]/pg;
			}
			for(i=0;i<6;i++) {
				if(joint[i][j]>0) {
					logsum[i]+=joint[i][j]*log(pcg[i]);
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
			for(i=0;i<6;i++){
				pg=0; for(l=0;l<6;l++) if(joint[l][j]>0) pg+=joint[l][j]*input_pdf[l];
				if(joint[i][j]>0){
					Info+=input_pdf[i]*joint[i][j]*log(joint[i][j]/pg)/log(2.);
					Info_vec[i]+=joint[i][j]*log(joint[i][j]/pg)/log(2.);
				}
			}
		}
		
		outfile_info<<Info<<endl;

	}

	for(i=0;i<6;i++) cout<<input_pdf[i]<<' ';
	cout<<Info<<endl;

}


					



