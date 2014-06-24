//
//  SharkHero.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 19/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "AnimObstacle.h"
#import "CCSprite.h"

@interface SharkHero : AnimObstacle

//-(CCSpriteBatchNode *) getSpriteSheet;
-(id) initWithImage;
-(void) screenTouched;
-(void) neutralCollision;

@end
