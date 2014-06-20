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
//#import "CCPhysicsBodyTypeStatic.h"
#import "CCScene.h"

@class SharkHero;

@interface MainGamePlay : CCScene <CCPhysicsCollisionDelegate>

+ (MainGamePlay *)scene;

-(id) init;

@end
