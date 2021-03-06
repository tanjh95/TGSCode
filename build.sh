## This MUST be run under the dir where the bld.sh is placed!!!

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(pwd)/../lib
echo "LD_LIBRARY_PATH=$LD_LIBRARY_PATH"
echo $LD_LIBRARY_PATH
PRONAME=TGSCodeV2
# G4DIR1002=/home/song67/geant4/g4.10.02p1/lib64/Geant4-10.2.1
# G4DIR1003=/home/song67/geant4/g4.10.03/lib64/Geant4-10.3.0
#G4DIR1003=/opt/Geant4/geant41004/lib64/Geant4-10.4.3/
G4DIR1003=/opt/Geant4/geant41005/lib64/Geant4-10.5.0/
#G4DIR1003=/home/tan/geant41005/g4install/lib64/Geant4-10.5.0/

cd ..
echo "======================================="
##sh 410.3.sh
cd $PRONAME

cd ../_bldlib
##rm * -rf
echo "======================================="
echo "=============start make libs==========="
# cmake ../
cmake -DGeant4_DIR=$G4DIR1003 -DCMAKE_INSTALL_PREFIX=../ ../
echo "============start make=========="
make -j4
echo "=======start make install======="
make install
echo "=============end  make libs==========="
echo " "
echo " "
cd ../$PRONAME

cd bld
##rm * -rf
echo "===============start cmake============="
echo "=======and copy the *.in & *.mac======="
# cmake ../
cmake -DGeant4_DIR=$G4DIR1003 -DCMAKE_INSTALL_PREFIX=../ ../
##Here, the first argument points CMake to our install of Geant4. Specifically, it is the directory holding the Geant4Config.cmake file. 
echo "============start make=========="
make -j4
if [ $? != 0 ]
then
cd 1111 #迫使脚本返回1
echo"++++1111"
else
echo "=======start make install======="
make install
if [ $? != 0 ]
then
cd 222 #迫使脚本返回1
echo "++++2222"
else
cd ../bin
fi
fi
