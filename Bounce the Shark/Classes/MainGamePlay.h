//
//  MainGamePlay.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 18/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCSprite.h"
#import "SharkHero.h"
#import "CCPhysicsNode.h"
#import "CCPhysicsBody.h"
#import "ObstacleFactory.h"
#import "SceneManager.h"
#import "CCScene.h"

@class SharkHero;

@interface MainGamePlay : CCScene <CCPhysicsCollisionDelegate>

@property (nonatomic, assign) CCTime     _totalTime;
@property (nonatomic, assign) CGFloat    _scrollSpeed;
@property (nonatomic, assign) NSUInteger _metresTraveled;

-(void)         initDisplayBoard;
-(id)           init             : (CGFloat) scrollSpeed;
+(MainGamePlay *)scene           : (CGFloat) scrollSpeed;

@end
