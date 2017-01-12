#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include<string>
#include<stdlib.h>

using namespace std;

int main(int argc,char** argv){

	// argv[1] = Genotype
	// argv[2] = 1(for ADF), 2(for ASI) or 3(for NSM)
	// argv[3] = pdf folder
	// argv[4] = gridsize

	if(argc<5) {
		cout<<"-------------------------------------"<<endl;
		cout<<"1D Channel Capacity Calculator"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <X> <folder name> <gridsize> <group>"<<endl;
		exit(0);
	}


	ifstream infile[6];
	ofstream outp("inpdf1D.dat");
	const int gridsize=atoi(argv[4]);
	int i,l,j,k;
	int counter=0;

        stringstream filename;

	string foodlist[6] = {"1", "2e+07", "6.3e+07", "6.3e+08", "2e+09", "1.1e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		filename<<argv[3]<<"/pdf1D"<<argv[2]<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<argv[5]<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	ofstream outfile_info("info.dat");
	ofstream outfile_bdbyfood("bdbyfood.dat");


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


	// From all QL196  
	//double Pinput3Dmax[6]={0.447823, 1.23438e-127, 3.01869e-68, 0.346158, 4.28946e-21, 0.20602};
	// From all QL404
	//double Pinput3Dmax[6]={0.389131, 0.0233961, 1.50518e-13, 0.327774, 5.05232e-08, 0.2597};
	// From all QL402
	//double Pinput3Dmax[6]={0.177805, 0.22745, 0.00015111, 0.258977, 0.0445254, 0.291091};
	// From all QL435
	//double Pinput3Dmax[6]={0.403121, 0.03592, 0.0350744, 0.311838, 0.000184441, 0.213861};
	//double infovec[6];

	//for(i=0;i<6;i++) cout<<input_pdf[i]<<' ';
	//cout<<Info<<' '<<MInfo2((double*)joint,Pinput3Dmax,gridsize,6)<<endl;
	//MInfo_vec((double*)joint,Pinput3Dmax,gridsize,6,infovec);
	//for(i=0;i<6;i++) outfile_bdbyfood<<infovec[i]<<' ';
	//outfile_bdbyfood<<endl;


}


					



