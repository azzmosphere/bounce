//
//  SharkHero.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 19/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "SharkHero.h"

@implementation SharkHero

const static CGFloat SHARK_X_PULSE       = 0.0f;
const static CGFloat SHARK_IMPULSE_SPEED = 800.0f;
const static int     FRAMES              = 3;
const static CGFloat RECT_OFFSET         = 0.2f;
const static CGFloat RECT_OFFSET2        = 0.1f;

-(id) initWithImage
{
    self = [super initWithImageNamed:@"sharkhero.png"];
    CGFloat rectOffset  = self.contentSizeInPoints.height * RECT_OFFSET;
    CGFloat rectOffset2 = self.contentSizeInPoints.height * RECT_OFFSET2;
    self = [super initWithImage:@"sharkhero.png"
                      withPlist:@"sharkhero.plist"
                 withFrameCount: FRAMES
                  withSprintStr:@"shark0%d-ipad.png"
              withCollisionType:@"hero"
               withBoundingBody: CGRectMake(CGPointZero.x + rectOffset + rectOffset2,
                                            CGPointZero.y + rectOffset,
                                            (self.contentSizeInPoints.width / FRAMES)  - rectOffset,
                                            self.contentSizeInPoints.height - (rectOffset + rectOffset2))];
    return self;
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

-(void) positiveCollision
{
    // Play any audio for doing something positive.
}

-(void) negativeCollision
{
    // Play any audio for doing something positive.
}


@end
