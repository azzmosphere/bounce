//
//  Obstacle.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 22/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCPhysicsBody.h"
#import "CCSprite.h"

@interface Obstacle : CCSprite

-(BOOL) getIsAttached;
-(void) setIsAttached : (BOOL) isAttached;

-(void) attachBoundingBody : (CGRect) boundingBody
         withCollisionType : (NSString *) collisionType;

-(void) attachBoundingBody : (CGRect)            boundingBody
         withCollisionType : (NSString *)        collisionType
           withPhysicsType : (CCPhysicsBodyType) physicsType;

-(id) initWithImageNamedAndPhysics:(NSString *)  imageName
                  withBoundingBox : (CGRect)     boundingBox
                withCollisionType : (NSString *) collisionType;

@end
