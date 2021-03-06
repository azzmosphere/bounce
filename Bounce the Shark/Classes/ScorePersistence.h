//
//  ScorePersistence.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScorePersistence : NSObject

-(id) init;

-(void) writeToPresistence : (NSUInteger) level
                 withScore : (NSUInteger) points
             withTotalTime : (CGFloat) totalTime
        withMetresTraveled : (NSUInteger) metresTraveled;
@end
