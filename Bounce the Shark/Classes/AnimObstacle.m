//
//  AnimObstacle.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 24/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "AnimObstacle.h" 



@implementation AnimObstacle {
    CCSpriteBatchNode *_spriteSheet;
    CCAction          *_defaultAnim;
    
}

const int _FRAME_ORIN_LANDSCAPE = 0;
const int _FRAME_ORIN_PORTRAIT  = 1;

@synthesize FRAME_ORIN_LANDSCAPE = _FRAME_ORIN_LANDSCAPE;
@synthesize FRAME_ORIN_PORTRAIT  = _FRAME_ORIN_PORTRAIT;

/*
 *==============================================================================
 *==============================================================================
 */
-(id) initWithImage : (NSString *) imageName
          withPlist : (NSString *) plist
     withFrameCount : (int) frameCount
      withSprintStr : (NSString *) sprintRef
  withCollisionType : (NSString *) collisionType
    withOrientation : (int)        orien
{
    
    // Setup animation.
    self = [super initWithImageNamed:imageName];
    
    CGFloat awidth  = (orien == self.FRAME_ORIN_LANDSCAPE)?
         self.contentSizeInPoints.width / frameCount:
         self.contentSizeInPoints.width;
    CGFloat aheight = (orien == self.FRAME_ORIN_PORTRAIT)?
         self.contentSizeInPoints.height / frameCount:
         self.contentSizeInPoints.height;
    
    self = [self initWithImage:imageName
                     withPlist:plist
                withFrameCount:frameCount
                 withSprintStr:sprintRef
             withCollisionType:collisionType
              withBoundingBody:CGRectMake(
                                          CGPointZero.x,
                                          CGPointZero.y,
                                          awidth,
                                          aheight
              )
     ];

    
    return self;
}


/*
 *==============================================================================
 *==============================================================================
 */
-(id) initWithImage : (NSString *) imageName
          withPlist : (NSString *) plist
     withFrameCount : (int) frameCount
      withSprintStr : (NSString *) sprintRef
  withCollisionType : (NSString *) collisionType
   withBoundingBody : (CGRect) boundingBody
{

    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:plist];
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:imageName];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<= frameCount; i++) {
        NSLog(sprintRef,i);
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:sprintRef,i]]];
    }
    
    CCAnimation *defaultAnim = [CCAnimation
                                animationWithSpriteFrames:walkAnimFrames delay:0.3f];
    _defaultAnim = [CCActionRepeatForever actionWithAction:
                    [CCActionAnimate actionWithAnimation:defaultAnim]];
    [self runAction:_defaultAnim];
    [_spriteSheet addChild:self];
    
    NSLog(@"obstalce is %f x %f", self.contentSizeInPoints.width,self.contentSizeInPoints.height);
    
    self.physicsBody = [CCPhysicsBody
                        bodyWithRect: boundingBody
                        cornerRadius: 0];
    self.physicsBody.allowsRotation    = FALSE;
    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.collisionType     = collisionType;
    
    return self;
}



/*
 *==============================================================================
 *==============================================================================
 */
-(CCSpriteBatchNode *) getSpriteSheet
{
    return _spriteSheet;
}


@end
