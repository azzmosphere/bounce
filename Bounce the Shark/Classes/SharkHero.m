//
//  SharkHero.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 19/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "SharkHero.h"

@implementation SharkHero {
    CCAction          *_swimAnim;
    CCSpriteBatchNode *_spriteSheet;
}

-(id) initWithImage
{
    // Setup animation.
    self = [super initWithImageNamed:@"sharkhero.png"];
    
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"sharkhero.plist"];
    _spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"sharkhero.png"];
    
    
    NSMutableArray *walkAnimFrames = [NSMutableArray array];
    for (int i=1; i<=3; i++) {
        NSLog(@"iteration frame:shark%d.png",i);
        [walkAnimFrames addObject:
         [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
          [NSString stringWithFormat:@"shark0%d.png",i]]];
    }
    
    CCAnimation *swimAnim = [CCAnimation
                             animationWithSpriteFrames:walkAnimFrames delay:0.3f];
    _swimAnim = [CCActionRepeatForever actionWithAction:
                 [CCActionAnimate actionWithAnimation:swimAnim]];
    [self runAction:_swimAnim];
    [_spriteSheet addChild:self];
    
    self.physicsBody = [CCPhysicsBody bodyWithRect:
                        CGRectMake(self.position.x * 0.8,
                                   self.position.y * 0.8,
                                   self.contentSize.width * 0.8,
                                   self.contentSize.height * 0.8)
                   cornerRadius:0];
    
    self.physicsBody.affectedByGravity = TRUE;
    
    return self;
}

-(CCSpriteBatchNode *) getSpriteSheet
{
    return _spriteSheet;
}

@end
