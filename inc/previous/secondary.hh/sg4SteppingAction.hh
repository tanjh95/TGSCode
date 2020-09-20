// sg4StepingAction.hh --- 
// 
// Description: 
// Author: David(侯英伟)
// Created: 五 9月 14 09:41:13 2018 (+0800)
// Last-Updated: 五 9月 21 20:46:21 2018 (+0800)
//           By: David(侯英伟)
//     Update #: 34
// URL:http://125.223.127.17:1118/wordpress/index.php/author/yingwei1990/ 

// 
// sg4StepingAction.hh ends here

#include "G4UserSteppingAction.hh"
#include "G4Track.hh"
#include "G4Event.hh"
#include "sg4SecondaryElectron.hh"
// #include "nuxVProc.hh" //该文件可能没有


class sg4SteppingAction : public G4UserSteppingAction
{
public:
  sg4SteppingAction();
  virtual ~sg4SteppingAction();

  virtual void UserSteppingAction(const G4Step*);
// protected:
//   void AddSecondary(const G4Track& aTrack,const G4Step& aStep);

private:
  // G4Event* theEvent;
  // G4int theEventID;
  G4Track* theTrack;
  G4int theTrackID;
  G4double EdepPerStep;
  //sg4SecondaryElectron* SecondaryGenerator;
};
