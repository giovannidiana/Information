#include<iostream>
#include<vector>
#include<fstream>
#include<cstdlib>
#include"mylib.h"
#include"TROOT.h"
#include"TH1.h"

using namespace std;

double info(TH2F *hist){

	TH1* histX = new TH1F(hist->ProjectionX());
	TH1* histY = new TH1F(hist->ProjectionY());

	int Ntot=hist->GetEntries();
	int xybin=histX->GetBins();
	int j;
	double info=0,pxy;

	for(i=0;i<xybin;i++){
		 for(j=0;j<xybin;j++){
			   pxy=hist->GetBinContent(i,j)/Ntot;
			     if(pxy!=0){
				        info+=pxy*log(pxy/(histX->GetBinContent(i)/Ntot*histY->GetBinContent(j)/Ntot));
			     }
		 }
	}

	return info;

}
