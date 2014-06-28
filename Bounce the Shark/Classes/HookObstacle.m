//
//  HookObstacle.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 24/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "HookObstacle.h"

@implementation HookObstacle

static const int     FRAMES  = 2;
static const CGFloat HOOK_SZ = 0.2f;

/*
 *==============================================================================
 *==============================================================================
 */
-(id) initWithImage
{
    self = [super initWithImageNamed:@"hook.png"];
    self = [super initWithImage:@"hook.png"
                      withPlist:@"hook.plist"
                 withFrameCount: FRAMES
                  withSprintStr:@"hook%d.png"
              withCollisionType:@"hook"
               withBoundingBody: CGRectMake(CGPointZero.x,
                                            CGPointZero.y,
                                            self.contentSizeInPoints.width,
                                            (self.contentSizeInPoints.height / FRAMES) * HOOK_SZ)
                withPhysicsType: CCPhysicsBodyTypeStatic];
    return self;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(CGFloat) getContentHeight
{
    return self.contentSizeInPoints.height / FRAMES;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(CGFloat) getMinContentHeight
{
    return (self.contentSizeInPoints.height / FRAMES) * 0.6;
}
@end
