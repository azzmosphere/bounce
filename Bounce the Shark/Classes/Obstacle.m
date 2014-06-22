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

-(BOOL) getIsAttached
{
    return _isAttached;
}

-(void) setIsAttached : (BOOL) isAttached
{
    _isAttached = isAttached;
}

@end
