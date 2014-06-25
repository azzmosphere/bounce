//
//  Obstacle.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 22/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

/*
 *==============================================================================
 * This the Obstacle base class, it contains common methods that are used by
 * by all obstacles.
 *==============================================================================
 */

#import "Obstacle.h"

@implementation Obstacle {
    BOOL _isAttached;
}

-(id) initWithImageNamed : (NSString *) imageName
{
    self  = [super initWithImageNamed:imageName];
    _isAttached = FALSE;
    self.anchorPoint = ccp(CGPointZero.x,CGPointZero.y);
    return self;
}


-(id) initWithImageNamedAndPhysics:(NSString *)  imageName
                  withBoundingBox : (CGRect)     boundingBox
                withCollisionType : (NSString *) collisionType
{
    [self attachBoundingBody:boundingBox
           withCollisionType:collisionType];
    return self;
}

-(void) attachBoundingBody : (CGRect) boundingBody
        withCollisionType : (NSString *) collisionType
{
    [self attachBoundingBody:boundingBody
           withCollisionType:collisionType
             withPhysicsType:CCPhysicsBodyTypeDynamic];
}

-(void) attachBoundingBody : (CGRect)            boundingBody
         withCollisionType : (NSString *)        collisionType
           withPhysicsType : (CCPhysicsBodyType) physicsType
{
    self.physicsBody = [CCPhysicsBody
                        bodyWithRect: boundingBody
                        cornerRadius: 0];
    self.physicsBody.allowsRotation    = FALSE;
    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.collisionType     = collisionType;
    self.physicsBody.type              = physicsType;
}

-(BOOL) getIsAttached
{
    return _isAttached;
}

-(void) setIsAttached : (BOOL) isAttached
{
    _isAttached = isAttached;
}

@end
