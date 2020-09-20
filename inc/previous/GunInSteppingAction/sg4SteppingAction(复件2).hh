// sg4StepingAction.hh --- 
// 
// Description: 
// Author: David(侯英伟)
// Created: 五 9月 14 09:41:13 2018 (+0800)
// Last-Updated: 六 9月 22 10:13:27 2018 (+0800)
//           By: David(侯英伟)
//     Update #: 48
// URL:http://125.223.127.17:1118/wordpress/index.php/author/yingwei1990/ 

// 
// sg4StepingAction.hh ends here

#include "G4UserSteppingAction.hh"
#include "G4Track.hh"
#include "G4Event.hh"
////
#include "G4ParticleGun.hh"
#include "G4ParticleTable.hh"
#include "G4ThreeVector.hh"
#include <iostream>
// #include "nuxVProc.hh" //该文件可能没有


class sg4SteppingAction : public G4UserSteppingAction
{
public:
  sg4SteppingAction();
  virtual ~sg4SteppingAction();
  virtual void GenerateParticleGun(const G4Step*);////
  virtual void UserSteppingAction(const G4Step*);
// protected:
//   void AddSecondary(const G4Track& aTrack,const G4Step& aStep);

private:
  // G4Event* theEvent;
  // G4int theEventID;
  G4Track* theTrack;
  G4int theTrackID;
  G4double EdepPerStep;
  ////////////////
  G4int nofpar;
  G4double Ekofpar;
  G4ThreeVector Momentumofpar;
  G4ThreeVector Positionofpar;
  G4ParticleGun *particleGun;
  sg4SteppingAction * ParticleGunGenerator;
};
