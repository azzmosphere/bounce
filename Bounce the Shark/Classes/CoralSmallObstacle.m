//
//  CoralSmallObstacle.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 22/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CoralSmallObstacle.h"

@implementation CoralSmallObstacle

-(id) initWithImage
{
    self = [super initWithImageNamed:@"coral-1.png"];
    return self;
}

-(id) initWithImageAndPhysicsBody
{
    self = [self initWithImage];
    
    // Attach the physicsBody.
    self.physicsBody = [CCPhysicsBody
                        bodyWithRect: [self boundingBox]
                        cornerRadius: 0];
    self.physicsBody.type          = CCPhysicsBodyTypeStatic;
    self.physicsBody.collisionType = @"coral_small";
    return self;
}
@end
