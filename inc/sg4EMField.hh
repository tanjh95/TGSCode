// sg4EMField.hh - 
// YushouSong, 宋玉收
// email : songyushou_cn@yahoo.com.cn
// Created On      : Tue Feb 19 15:00:11 2013
// Last Modified On: Wed May 11 16:02:12 2016
// Update Count    : 17
// 

#ifndef sg4EMField_hh
#define sg4EMField_hh
#include "G4ios.hh"
#include "globals.hh"
#include "G4ElectroMagneticField.hh"


class sg4EMField : public G4ElectroMagneticField 
{
public:

  sg4EMField();
  virtual ~sg4EMField();


  virtual void GetFieldValue(const G4double* pos, G4double *Bfield) const;
  // pos[4] x, y, z, t
  // Return as Bfield[0], [1], [2] the magnetic field x, y & z components
  // and   as Bfield[3], [4], [5] the electric field x, y & z components
  virtual G4bool   DoesFieldChangeEnergy() const { return true; }

private:

};

#endif 
