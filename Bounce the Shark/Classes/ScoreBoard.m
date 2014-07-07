//
//  ScoreBoard.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ScoreBoard.h"

@implementation ScoreBoard {
    CCLayoutBox *_scorboard;
}

-(id) init
{
    self = [super init];
    if(self == nil)
        return self;
    
    
    //Create buttons
    [self createButtonWithTitle:@"restart" andSelector:@"restart:"];
    
    CGSize cs = [[CCDirector sharedDirector] viewSize];
    cs.width  = cs.width  / 2 - self._layoutBox.contentSize.width /2;
    cs.height = cs.height * 0.8f;
    
    self._layoutBox.position = ccp(cs.width,cs.height);
    [self addChild:self._layoutBox];
    
    // Get latest score and add it to persistence class
    _scorboard = [[CCLayoutBox alloc] init];
    
    [self addChild:_scorboard];
    
    return self;
}



/*
 *==============================================================================
 * Restart button clicked.
 *==============================================================================
 */
-(void) restart: (id) sender
{
    NSLog(@"Restart button has been pressed");
    [[SceneManager instance] changeScene: BTSMainGameIntroScene];
}

@end
