//
//  SharkHero.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 19/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCAnimation.h"
#import "CCSpriteFrameCache.h"
#import "CCSpriteBatchNode.h"
#import "CCAction.h"
#import "CCActionInterval.h"
#import "CCPhysicsBody.h"
#import "CCSprite.h"

@interface SharkHero : CCSprite

-(CCSpriteBatchNode *) getSpriteSheet;
-(id) initWithImage;
-(void) screenTouched;

@end
