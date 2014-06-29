//
//  Coin.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 25/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "Coin.h"

@implementation Coin

@synthesize scoreweight = scoreweight;

-(id) initWithImage
{
    self = [super initWithImageNamed:@"coin.png"];
    [self attachBoundingBody : CGRectMake(
                                          CGPointZero.x,
                                          CGPointZero.y,
                                          self.contentSizeInPoints.width,
                                          self.contentSizeInPoints.height)
           withCollisionType : @"coin"
             withPhysicsType : CCPhysicsBodyTypeStatic];
    scoreweight = 1;
    return self;
}


@end
