//
//  ObstacleFactory.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCPhysicsNode.h"
#import "CoralSmallObstacle.h"
#import "CoralLargeObstacle.h"
#import "HookObstacle.h"
#import "Coin.h"
#import "CCScene.h"
#import "CCNode.h"

@interface ObstacleFactory : NSObject


// Setable options
@property (nonatomic, assign) CCPhysicsNode *physicsWorld;
@property (nonatomic, assign) CGFloat        firstObstacleXpos;

// Large coral random seeds,  set the CORAL_UPPER_SEED higher to make
// the objects appear less frequently on the screen
@property (nonatomic, assign) int coral_lg_upper_seed;
@property (nonatomic, assign) int coral_lg_lower_seed;

@property (nonatomic, assign) int coral_sm_upper_seed;
@property (nonatomic, assign) int coral_sm_lower_seed;

@property (nonatomic, assign) int hook_upper_seed;
@property (nonatomic, assign) int hook_lower_seed;

@property (nonatomic, assign) int coin_upper_seed;
@property (nonatomic, assign) int coin_lower_seed;

@property (nonatomic, assign) CCScene *gameScene;


// METHODS
//-(void) spawnNewObstacle;
-(void) updateObstacles;
-(id)   initWithPhysicsNode : (CCPhysicsNode *) world;

@end
