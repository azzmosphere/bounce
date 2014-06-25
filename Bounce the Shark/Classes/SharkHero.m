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
const static CGFloat SHARK_IMPULSE_SPEED = 150.0f;
const static int     FRAMES              = 3;
const static int     RECT_OFFSET         = 20;

-(id) initWithImage
{
   self = [super initWithImageNamed:@"sharkhero.png"];
   self = [super initWithImage:@"sharkhero.png"
                      withPlist:@"sharkhero.plist"
                 withFrameCount: FRAMES
                  withSprintStr:@"shark0%d-ipad.png"
              withCollisionType:@"hero"
               withBoundingBody: CGRectMake(CGPointZero.x + RECT_OFFSET,
                                            CGPointZero.y + RECT_OFFSET,
                                            self.contentSizeInPoints.width / FRAMES,
                                            self.contentSizeInPoints.height)];
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


@end
