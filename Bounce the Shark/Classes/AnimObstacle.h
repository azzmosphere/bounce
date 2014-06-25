//
//  AnimObstacle.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 24/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCSpriteFrameCache.h"
#import "CCSpriteBatchNode.h"
#import "CCAnimation.h"
#import "CCAction.h"
#import "Obstacle.h"
#import "CCPhysicsBody.h"

@interface AnimObstacle : Obstacle

extern const int _FRAME_ORIN_LANDSCAPE;
extern const int _FRAME_ORIN_PORTRAIT;

// FRAME ORIENTATION
@property (nonatomic, readonly) int FRAME_ORIN_LANDSCAPE;
@property (nonatomic, readonly) int FRAME_ORIN_PORTRAIT;


// METHOD DEFINITION
-(id) initWithImage : (NSString *) imageName
          withPlist : (NSString *) plist
     withFrameCount : (int) frameCount
      withSprintStr : (NSString *) sprintRef
  withCollisionType : (NSString *) collisionType
    withOrientation : (int)        orien;

-(id) initWithImage : (NSString *) imageName
          withPlist : (NSString *) plist
     withFrameCount : (int) frameCount
      withSprintStr : (NSString *) sprintRef
  withCollisionType : (NSString *) collisionType
   withBoundingBody : (CGRect) boundingBody;

-(id) initWithImage : (NSString *) imageName
          withPlist : (NSString *) plist
     withFrameCount : (int) frameCount
      withSprintStr : (NSString *) sprintRef
  withCollisionType : (NSString *) collisionType
   withBoundingBody : (CGRect) boundingBody
    withPhysicsType : (CCPhysicsBodyType) physicsType;

-(CCSpriteBatchNode *) getSpriteSheet;

@end
