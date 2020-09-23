#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#include <sstream>
#include <math.h>
using namespace std;
double d0=196.5;//mm  探测器到桶表面垂直距离
double Col_D=13;//mm 准直器内直径
double Col_L=100;//mm准直器长度
double bucket_D=150;//mm 废物桶边长
double pi=3.1415926;
void angleCal(double numX,double numY,double numZ){
FILE *fp;
fp=fopen("angledata.temp","w");//每次重写
double angle_temp=atan((-numX)/(d0+bucket_D*0.5-numZ));//倾角 rad表示
double L0=fabs(sin(angle_temp))*Col_L;//中间变量
if(L0==0){
L0=0.5*Col_D;
}
double L=pow((pow(d0+bucket_D*0.5-Col_L-numX,2)+pow(numZ,2)),0.5);//L 中间变量
double Theta_temp=asin((L0)/L);//3是修正量 补充张角
double angle=180*angle_temp/pi;
double Theta=180*Theta_temp/pi;
fprintf(fp,"%f\t%f",angle,Theta);
fclose(fp);

}

int  main(int argc,char *argv[]){
string str1=argv[1];
string str2=argv[2];
string str3=argv[3];
double numX=0,numY=0,numZ=0;
stringstream ss;
ss<<str1;ss>>numX;ss.clear();
ss<<str2;ss>>numY;ss.clear();
ss<<str3;ss>>numZ;ss.clear();
//cout<<numX<<" "<<numY<<" "<<numZ<<endl;
angleCal(numX,numY,numZ);
return 0;
}
