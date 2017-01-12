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
	// argv[2] = group
	// argv[3] = pdf folder
	// argv[4] = gridsize

	if(argc==1) {
		cout<<"-------------------------------------"<<endl;
		cout<<"Channel Capacity Summary"<<endl;
                cout<<"G. Diana."<<endl;
		cout<<"-------------------------------------"<<endl;
                cout<<"\tUsage:"<<endl;
		cout<<"\tCCap <Genotype> <group> <folder name> <gridsize>"<<endl;
		exit(0);
	}


	ifstream infile[6];
	ifstream inpdf_file("/home/diana/workspace/Analysis/Information/inpdf.dat"); 
	const int gridsize=atoi(argv[4]);
	const int group=atoi(argv[2]);
	int i,l,j,k,l1;
	int counter=0;

        stringstream filename;

	string foodlist[6] = {"1", "2e+07", "6.3e+07", "6.3e+08", "2e+09", "1.1e+10"};

	for(i=0;i<6;i++){
		filename.str("/home/diana/workspace/Analysis/R_projects/");
		filename.seekp(0, ios_base::end);
		filename<<argv[3]<<"/pdf3D"<<'_'<<argv[1]<<"_"<<foodlist[i]<<"_GS"<<gridsize<<"_group"<<group<<".dat";
		infile[i].open(filename.str().c_str());
	}
	
	ofstream outfile_info("info.dat");

	double joint[6][gridsize][gridsize][gridsize];

	for(i=0;i<6;i++){
		for(j=0;j<gridsize;j++){
			for(k=0;k<gridsize;k++){
				for(l=0;l<gridsize;l++){
					infile[i]>>joint[i][j][k][l];
					if(joint[i][j][k][l]==0) joint[i][j][k][l]=1e-12;
				}
			}
		}
	}

	double input_pdf[6];
	for(k=0;k<6;k++){
		inpdf_file>>input_pdf[k];
	}
	inpdf_file.close();

/*	double input_pdfQL196[6]={0.447823, 1.23438e-127, 3.01869e-68, 0.346158, 4.28946e-21, 0.20602};
	double input_pdfQL402[6]={0.177805, 0.22745, 0.00015111, 0.258977 ,0.0445254, 0.291091};
	double input_pdfQL404[6]={0.389131, 0.0233961, 1.50518e-13, 0.327774, 5.05232e-08, 0.2597};
	double input_pdfQL435[6]={0.403121, 0.03592, 0.0350744, 0.311838, 0.000184441, 0.213861};

	if(argv[1]==string("QL196")) for(i=0;i<6;i++) input_pdf[i]=input_pdfQL196[i];
	if(argv[1]==string("QL404")) for(i=0;i<6;i++) input_pdf[i]=input_pdfQL404[i];
	if(argv[1]==string("QL402")) for(i=0;i<6;i++) input_pdf[i]=input_pdfQL402[i];
	if(argv[1]==string("QL435")) for(i=0;i<6;i++) input_pdf[i]=input_pdfQL435[i];
*/	
	double pg=0;
	double pcg[6];
	double logsum[6];
	double Z=0;
	double Info=0;
	double Info_vec[6];
	int xyID=atoi(argv[2]);
	double PmargOverFood=0;

	
// NORMALIZATION
	for(k=0;k<6;k++){
		Z=0;
		for(i=0;i<gridsize;i++){
		for(j=0;j<gridsize;j++){
		for(l=0;l<gridsize;l++){
			Z+=joint[k][i][j][l];
		}
		}
		}

		for(i=0;i<gridsize;i++){
		for(j=0;j<gridsize;j++){
		for(l=0;l<gridsize;l++){
			joint[k][i][j][l]/=Z;
		}
		}
		}
	}

        // Set Info_vec to zero
	for(i=0;i<6;i++) Info_vec[i]=0;
	

	for(i=0;i<gridsize;i++){
	for(j=0;j<gridsize;j++){
	for(l=0;l<gridsize;l++){
		PmargOverFood=0;
		for(k=0;k<6;k++) PmargOverFood+=input_pdf[k]*joint[k][i][j][l];
		for(k=0;k<6;k++){
			if(joint[k][i][j][l]>0 && PmargOverFood>0) {
				Info+=joint[k][i][j][l]*input_pdf[k]*log(joint[k][i][j][l]/PmargOverFood)/log(2.);
				Info_vec[k]+=joint[k][i][j][l]*log(joint[k][i][j][l]/PmargOverFood)/log(2.);
			}
		}
	}
	}
	}

	for(i=0;i<6;i++) cout<<Info_vec[i]<<' ';
	cout<<Info<<endl;
}






					



