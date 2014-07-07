//
//  SceneManager.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 30/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "MainGamePlay.h"
#import "HeroDiedScene.h"
#import "ScoreBoard.h"
#import "CCNode.h"

@class MainGamePlay;

#define BTSMainGameIntroScene 0
#define BTSMainGamePlayScene  1
#define BTSHeroDiedScene      2
#define BTSMainGameContinue   3
#define BTSScoreBoard         4

#define SCROLL_SPEED     80.f
#define SCROLL_SPEED_INC 40.f

@interface SceneManager : CCNode

@property (nonatomic, assign) CGFloat    scrollSpeed;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, assign) NSUInteger points;
@property (nonatomic, assign) CGFloat    totalTime;
@property (nonatomic, assign) NSUInteger metresTraveled;


+ (SceneManager *)instance;
-(CCScene *)      getScene    : (NSUInteger) scene;
-(void)           changeScene : (NSUInteger) scene;
-(void)           resetDefaults;


@end
