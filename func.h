#include<iostream>

using namespace std;


double MInfo(double*,int);
double MInfo2(double*,double*,int,int);
void MInfo_vec(double*,double*,int,int,double*);

class sdouble {
	public:
		double fpart;
		int epart; 
		sdouble();
		sdouble(double,int);
		slog();
		dbl();
		sdouble operator*(const sdouble&);
		sdouble operator+(const sdouble&);
		void set(double);
}
		
	        

