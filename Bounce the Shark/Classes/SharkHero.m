//
//  SharkHero.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 19/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "SharkHero.h"

@implementation SharkHero {
    CCAction          *_swimAnim;
    CCSpriteBatchNode *_spriteSheet;
}

const static CGFloat SHARK_X_PULSE       = 0.0f;
const static CGFloat SHARK_IMPULSE_SPEED = 150.0f;
const static int     FRAMES              = 3;

-(id) initWithImage
{
    // Setup animation.
    self = [super initWithImageNamed:@"sharkhero.png"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sharkhero.plist"];
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sharkhero.png"];
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<= FRAMES; i++) {
        NSLog(@"iteration frame:shark0%d.png",i);
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"shark0%d-ipad.png",i]]];
    }
    
    CCAnimation *swimAnim = [CCAnimation
                             animationWithSpriteFrames:walkAnimFrames delay:0.3f];
    _swimAnim = [CCActionRepeatForever actionWithAction:
                 [CCActionAnimate actionWithAnimation:swimAnim]];
    [self runAction:_swimAnim];
    [_spriteSheet addChild:self];
    
    NSLog(@"shark is %f x %f", self.contentSizeInPoints.width,self.contentSizeInPoints.height);
    
    self.physicsBody = [CCPhysicsBody bodyWithRect:
                        CGRectMake(CGPointZero.x + 20,
                                   CGPointZero.y + 10,
                                   self.contentSizeInPoints.width / FRAMES,
                                   self.contentSizeInPoints.height)
                   cornerRadius:0];
    
    self.physicsBody.affectedByGravity = TRUE;
    self.physicsBody.collisionType     = @"hero";
    
    return self;
}


-(CCSpriteBatchNode *) getSpriteSheet
{
    return _spriteSheet;
}

/*
 *=============================================================================
 * This routine is called when the hero is touched.
 *=============================================================================
 */
-(void) screenTouched
{
    //OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    //[audio playEffect: (NSString *) SCR_TOUCHED_SEFFECT];
    [self.physicsBody applyImpulse:ccp(SHARK_X_PULSE, SHARK_IMPULSE_SPEED)];
    
}

-(void) neutralCollision
{
    //OALSimpleAudio *audio = [OALSimpleAudio sharedInstance];
    //[audio playEffect: (NSString *) SCR_TOUCHED_SEFFECT];
    [self.physicsBody applyImpulse:ccp(SHARK_X_PULSE, SHARK_IMPULSE_SPEED)];
    
}


@end
