//
//  Obstacle.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 22/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCSprite.h"

@interface Obstacle : CCSprite

-(BOOL) getIsAttached;
-(void) setIsAttached : (BOOL) isAttached;

@end
