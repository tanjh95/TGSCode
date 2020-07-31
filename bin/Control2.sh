#!/bin/bash

##控制MCP的厚度，孔径间距，倾角
tgshome=/home/tan/g4work/sg410mt/TGS2020
bin=/home/tan/g4work/sg410mt/TGS2020/bin
src=/home/tan/g4work/sg410mt/TGS2020/src
inc=/home/tan/g4work/sg410mt/TGS2020/inc
ChangePosition(){ ## barrel move，接收参数1  单位mm
cd $src
sed -i "59c   	par.xBarrel=$1*mm;//changed by sh" sg4Detector.cc  #.cc中的rchannel值
}

ChangeRotation(){  ##更改倾角 degree
cd $src
sed -i "63c   par.Degree=$1;//changed by sh" sg4Detector.cc
}

ChangeSource(){  ## 2 parameters x=$1 z=$2 *mm
cd $tgshome
sed -i "42c xInitPrimary $1 #changed by sh"  input.txt
sed -i "44c zInitPrimary $2 #changed by sh"  input.txt
}

ApplyRunTr(){ ## 接收参数:1.run.mac的序号 2.3.4.文件名命名方式
cd $tgshome
sed -i "47c xRangePrimary -3 #changed by sh" input.txt
sed -i "57c RangeThetaPri 0 #changed by sh" input.txt
. build.sh
if [ $? != 0 ]
then
echo "build error"
echo "script exit"
else
echo "Run Start"
./TGS run.mac  && hadd "Tr"$1"_"$2".root"  test_t*.root # Transmision
echo "Tr"$1"_"$2".root"

fi
}

ApplyRunEm(){ ## 接收参数:1.run.mac 2.barrel move 3.barrel rot 4.voxel nub which have source
cd $tgshome
sed -i "47c xRangePrimary 0 #changed by sh" input.txt
sed -i "57c RangeThetaPri 180 #changed by sh" input.txt
. build.sh
if [ $? != 0 ]
then
echo "build error"
echo "script exit"
else
echo "Run Start"
./TGS run.mac && hadd "Em"$1"_"$2"_"$3."root"  test_t*.root
echo "Em"$1"_"$2"_"$3".root"

fi
}


###主程序开始
echo "输入模式 1:transmission 2:emmision"
read modNb
case $modNb in
##Transmission
1)
 cd  $tgshome
 sed -i "42c xInitPrimary 0  #changed by sh" input.txt
 sed -i "44c zInitPrimary -100  #changed by sh" input.txt

 for loop2 in  -50 #  0 50 
  do
   for loop in  0 #45 90 135
   do
  ChangePosition $loop2
  ChangeRotation $loop
  ApplyRunTr $loop2 $loop
  done
  done
;;
2)
###Emmision
  for loop2 in  -50 #0 50
    do 
    for loop in 0 #45 90 135
      do
        ChangePosition  $loop2
        ChangeRotation  $loop
###source1(Nb6)
	X6=`echo "$loop $loop2" |awk '{printf("%g",50*cos(1*$1*3.1415926/180)+$2)}'`
	Z6=`echo "$loop" |awk '{printf("%g",50*sin(-1*$1*3.1415926/180))}'`
###source2(Nb4)
	X4=`echo "$loop $loop2" |awk '{printf("%g",-50*cos(1*$1*3.1415926/180)+$2)}'`
	Z4=`echo "$loop" |awk '{printf("%g",50*sin(1*$1*3.1415926/180))}'`
###soource9（Nb9)
	X9=`echo "$loop $loop2" |awk '{printf("%g",50*sqrt(2)*sin((45-$1)*3.1415926/180)+$2)}'` #first point
	Z9=`echo "$loop" |awk '{printf("%g",-50*sqrt(2)*cos((45-$1)*3.1415926/180))}'`
	
	X1=`echo "$loop $loop2" |awk '{printf("%g",-50*sqrt(2)*sin((45-$1)*3.1415926/180)+$2)}'` #first point
	Z1=`echo "$loop" |awk '{printf("%g",50*sqrt(2)*cos((45-$1)*3.1415926/180))}'`

	cd  $tgshome
	sed -i "42c xInitPrimary $X1  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z1  #changed by sh" input.txt


        ApplyRunEm  $loop2  $loop 1 # 4个参数不能少
        done 
  done
;;
3)

###Efficiency


    for loop in 45 #0  45  90 135
      do
	for loop2 in 0  #-50  0 50
	 do
        ChangePosition $loop2
        ChangeRotation  $loop

###source1(1)
	X1=`echo "$loop $loop2" |awk '{printf("%g",-50*sqrt(2)*sin((45-$1)*3.1415926/180)+$2)}'` #first point
	Z1=`echo "$loop" |awk '{printf("%g",50*sqrt(2)*cos((45-$1)*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X1  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z1  #changed by sh" input.txt


#  ApplyRunEm  $loop2  $loop 1 # position / angle degree/ pixel number

###source2(N2)
	X2=`echo "$loop $loop2" |awk '{printf("%g",50*sin(1*$1*3.1415926/180)+$2)}'`
	Z2=`echo "$loop" |awk '{printf("%g",50*cos(1*$1*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X2  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z2  #changed by sh" input.txt


#     ApplyRunEm $loop2  $loop 2 # source point / angle degree/ measure point

##soruce3
	X3=`echo "$loop $loop2" |awk '{printf("%g",50*sqrt(2)*cos((45-$1)*3.1415926/180)+$2)}'` #first point
	Z3=`echo "$loop" |awk '{printf("%g",50*sqrt(2)*cos((45+$1)*3.1415926/180))}'`

	cd  $tgshome
	sed -i "42c xInitPrimary $X3  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z3  #changed by sh" input.txt


#     ApplyRunEm $loop2  $loop 3 # source point / angle degree/ measure point
###source1(4)
	X4=`echo "$loop $loop2" |awk '{printf("%g",-50*cos($1*3.1415926/180)+$2)}'` #first point
	Z4=`echo "$loop" |awk '{printf("%g",50*sin($1*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X4  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z4  #changed by sh" input.txt


#      ApplyRunEm  $loop2  $loop 4 # source point / angle degree/ measure point
###source1(5)
	X5=`echo "$loop2" |awk '{printf("%g",$1)}'` #first point
	Z5=`echo "$loop" |awk '{printf("%g",0)}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X5  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z5  #changed by sh" input.txt


       ApplyRunEm  $loop2  $loop 5 # source point / angle degree/ measure point
###source1(6)
	X6=`echo "$loop $loop2" |awk '{printf("%g",50*cos($1*3.1415926/180)+$2)}'` #first point
	Z6=`echo "$loop" |awk '{printf("%g",-50*sin($1*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X6  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z6  #changed by sh" input.txt


       ApplyRunEm  $loop2  $loop 6 # source point / angle degree/ measure point
##soruce7
	X7=`echo "$loop $loop2" |awk '{printf("%g",-50*sqrt(2)*cos((45-$1)*3.1415926/180)+$2)}'` #first point
	Z7=`echo "$loop" |awk '{printf("%g",-50*sqrt(2)*cos((45+$1)*3.1415926/180))}'`

	cd  $tgshome
	sed -i "42c xInitPrimary $X7  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z7  #changed by sh" input.txt


     ApplyRunEm $loop2  $loop 7 # source point / angle degree/ measure point
###source8(N2)
	X8=`echo "$loop $loop2" |awk '{printf("%g",-50*sin(1*$1*3.1415926/180)+$2)}'`
	Z8=`echo "$loop" |awk '{printf("%g",-50*cos(1*$1*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X8  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z8  #changed by sh" input.txt


     ApplyRunEm $loop2  $loop 8 # source point / angle degree/ measure point
###source9
	X9=`echo "$loop $loop2" |awk '{printf("%g",50*sqrt(2)*sin((45-$1)*3.1415926/180)+$2)}'` #first point
	Z9=`echo "$loop" |awk '{printf("%g",-50*sqrt(2)*cos((45-$1)*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X9  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z9  #changed by sh" input.txt


  ApplyRunEm  $loop2  $loop 9 # position / angle degree/ pixel number

	done
  done
;;
4)
        ChangePosition  0
        ChangeRotation  0
for loop in 0
do
	for loop2 in 0
	do
##########measure2
	X9=`echo "$loop $loop2" |awk '{printf("%g",50*sqrt(2)*sin((45-$1)*3.1415926/180)+$2)}'` #first point
	Z9=`echo "$loop" |awk '{printf("%g",-50*sqrt(2)*cos((45-$1)*3.1415926/180))}'`
	cd  $tgshome
	sed -i "42c xInitPrimary $X9  #changed by sh" input.txt
	sed -i "44c zInitPrimary $Z9  #changed by sh" input.txt




done
done
;;
esac
cd $bin
