//
//  ObstacleFactory.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCPhysicsNode.h"
#import "CoralSmallObstacle.h"
#import "CCNode.h"

@interface ObstacleFactory : CCNode

//-(id) initWith :(CCPhysicsNode *) physicsNode
//           ctl :(CCNode *) ctl;

//-(void) spawnNewObstacle;
//-(void) updateObstacles;

+(void) initWithPhysicsNode : (CCPhysicsNode *) world;

@end
