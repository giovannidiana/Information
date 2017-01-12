#include<iostream>
#include<vector>
#include<sstream>
#include<fstream>
#include<cmath>
#include<string>
#include<stdlib.h>
#include<gsl/gsl_rng.h>
#include<gsl/gsl_randist.h>

using namespace std;

int main(int argc,char** argv){

	// argv[1] = Genotype
	// argv[2] = 1=adf/asi 2= adf/nsm 3=asi/nsm
	// argv[3] = pdf folder
	// argv[4] = gridsize
	// argv[5] = group

	if(argc==1) {
		cout<<"-------------------------------------"<<endl;
		cout<<"Channel Capacity Summary"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <xy> <folder name> <label> <gridsize> <group>"<<endl;
		exit(0);
	}

	const gsl_rng_type * T;
	gsl_rng * r;
	r = gsl_rng_alloc (gsl_rng_mt19937);
	//gsl_rng_set(r,(unsigned long)atoi(argv[6]));
	ifstream infile[6];
	stringstream inpdf_filename;
	inpdf_filename<<"/home/diana/workspace/Analysis/Information/"
		      <<"inpdf_"<<argv[1]<<".dat";
	ifstream inpdf_file(inpdf_filename.str().c_str());
	const int gridsize=atoi(argv[5]);
	const int group=atoi(argv[6]);
	int i,l,j,k,l1;
	int counter=0;
	double Z=0;

        stringstream filename;

	string foodlist[6] = {"1", "2e+07", "6.3e+07", "6.3e+08", "2e+09", "1.1e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		//filename<<argv[3]<<"/pdf3D"<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<group<<".dat";
		filename<<argv[3]<<"/"<<argv[4]<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<group<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	double joint[6][gridsize][gridsize];

	for(i=0;i<6;i++){
		for(j=0;j<gridsize;j++){
			for(l=0;l<gridsize;l++){
				infile[i]>>joint[i][j][l];
			}
		}
	}
	double input_pdf[6];
	Z=0;
	for(k=0;k<6;k++) { 
		inpdf_file>>input_pdf[k];
	}

        
	for(k=0;k<6;k++) {
		Z+=input_pdf[k];
	}
	for(k=0;k<6;k++) input_pdf[k]/=Z;
	
	inpdf_file.close();

	double pg=0;
	double pcg[6];
	double logsum[6];
	double Info=0;
	double Info_vec[6];
	int xyID=atoi(argv[2]);
	double jointX[6][gridsize];
	double PmargOverFood=0;

	for(k=0;k<6;k++){
		for(i=0;i<gridsize;i++){
			jointX[k][i]=0;
			if(xyID==1){
				for(l=0;l<gridsize;l++){
					jointX[k][i]+=joint[k][i][l];
				}
			}
			if(xyID==2){
				abort();
			}
			if(xyID==3){
				for(l=0;l<gridsize;l++){
					jointX[k][i]+=joint[k][l][i];
				}
			}
		}
	}

// NORMALIZATION
	for(k=0;k<6;k++){
		Z=0; for(i=0;i<gridsize;i++) Z+=jointX[k][i];
		for(i=0;i<gridsize;i++) jointX[k][i]/=Z;
	}


        // Initialize Info_vec to zero 
	for(i=0;i<6;i++) Info_vec[i]=0;

	for(i=0;i<gridsize;i++){
		PmargOverFood=0;
		for(k=0;k<6;k++) PmargOverFood+=input_pdf[k]*jointX[k][i];
		for(k=0;k<6;k++){
			if(jointX[k][i]>0 && PmargOverFood>0) {
				Info+=jointX[k][i]*input_pdf[k]*log(jointX[k][i]/PmargOverFood)/log(2.);
				Info_vec[k]+=jointX[k][i]*log(jointX[k][i]/PmargOverFood)/log(2.);
				//if(Info_vec[k]!=Info_vec[k]){
				//	cout<<jointX[k][i]<<' '<<input_pdf[k]<<' '<<PmargOverFood<<endl;
				//}
			}
		}
	}
	

	for(i=0;i<6;i++) cout<<Info_vec[i]<<' ';
	cout<<Info<<endl;
}






					



