//
//  HeroDiedScene.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 1/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCSprite.h"
#import "CCButton.h"
#import "CCLayoutBox.h"
#import "CCDirector.h"
#import "SceneManager.h"
#import "CCScene.h"

#import "DecisionScene.h"

@interface HeroDiedScene : DecisionScene


-(void) restart: (id) sender;
-(void) continue: (id) sender;

@end
