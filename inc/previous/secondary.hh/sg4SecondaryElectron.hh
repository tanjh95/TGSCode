// sg4Secondary.hh --- 
// 
// Description: 
// Author: David(侯英伟)
// Created: 四 9月 20 21:06:48 2018 (+0800)
// Last-Updated: 五 9月 21 11:23:57 2018 (+0800)
//           By: David(侯英伟)
//     Update #: 57
// URL:http://125.223.127.17:1118/wordpress/index.php/author/yingwei1990/ 
#include "G4ParticleGun.hh"
#include "G4ParticleTable.hh"
#include "G4ThreeVector.hh"
#include <iostream>
using namespace std;
// class G4ParticleTable;
// class G4ParticleDefinition;
class sg4SecondaryElectron : public G4ParticleGun,public G4ParticleTable
{
public:
  // sg4SecondaryElectron();
  // virtual ~sg4SecondaryElectron();
  
  //method
 virtual void GenerateParticleGun();

  private:
  G4int nofpar;
  G4double Ekofpar;
  G4ThreeVector Momentumofpar;
  G4ThreeVector Positionofpar;
  G4ParticleGun *particleGun;
  //G4ParticleTable *ParticleTable;
  
};

void sg4SecondaryElectron::GenerateParticleGun()
{
  nofpar=1;
  Ekofpar=10;
  Momentumofpar=G4ThreeVector(0,0,1);
  Positionofpar=G4ThreeVector(0,0,0);
  particleGun= new G4ParticleGun(nofpar);
  G4ParticleTable* ParticleTable=G4ParticleTable::GetParticleTable();
  G4ParticleDefinition* particle= ParticleTable->FindParticle("e-");
  particleGun->SetParticleDefinition(particle);
  particleGun->SetParticleEnergy(Ekofpar);
  particleGun->SetParticlePosition(Positionofpar);
  particleGun->SetParticleMomentumDirection(Momentumofpar);
}

// sg4SecondaryElectron::sg4SecondaryElectron()
// {
//   cout<<"created class secondary"<<endl;
// }

// sg4SecondaryElectron::~sg4SecondaryElectron()
// {
//   if (particleGun)
//     {
//       delete particleGun;
//       cout<<"delete particleGun"<<endl;
//     }
//   cout<<"deconstruction"<<endl;
// }
// 
// sg4Secondary.hh ends here
