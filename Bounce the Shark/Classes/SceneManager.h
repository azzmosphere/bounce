//
//  SceneManager.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 30/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "MainGamePlay.h"
#import "HeroDiedScene.h"
#import "CCNode.h"

#define BTSMainGameIntroScene 0
#define BTSMainGamePlayScene  1
#define BTSHeroDiedScene      2

#define SCROLL_SPEED 80.f

@interface SceneManager : CCNode

+ (SceneManager *)instance;
-(CCScene *)      getScene    : (NSUInteger) scene;
-(void)           changeScene : (NSUInteger) scene;

@end
