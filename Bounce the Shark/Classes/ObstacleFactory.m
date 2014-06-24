//
//  ObstacleFactory.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ObstacleFactory.h"

@implementation ObstacleFactory

+(void) initWithPhysicsNode : (CCPhysicsNode *) world
{
    // randomly add coral
    //CoralSmallObstacle *coral1 = [[CoralSmallObstacle alloc] initWithImageAndPhysicsBody];
    //CoralLargeObstacle *obstacle = [[CoralLargeObstacle alloc] initWithImageAndPhysicsBody];
    HookObstacle *obstacle = [[HookObstacle alloc] initWithImage];
    [obstacle setPosition:ccp(900,0)];
    [obstacle setAnchorPoint:ccp(0,0)];
    //[world addChild: obstacle];
    
    [world addChild: [obstacle getSpriteSheet]];
}

@end
