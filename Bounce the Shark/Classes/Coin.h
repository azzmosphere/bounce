//
//  Coin.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 25/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "Obstacle.h"

@interface Coin : Obstacle

@property (nonatomic, assign) NSUInteger scoreweight;

-(id)         initWithImage;

@end
