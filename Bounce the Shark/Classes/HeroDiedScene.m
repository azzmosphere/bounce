//
//  HeroDiedScene.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 1/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "HeroDiedScene.h"

@implementation HeroDiedScene

/*
 *==============================================================================
 * Class initiliser
 *==============================================================================
 */
-(id) init
{
    self = [super init];
    
    if( self == nil )
        return self;
    
    //Create buttons
    [self createButtonWithTitle:@"continue" andSelector:@"continue:"];
    [self createButtonWithTitle:@"restart"  andSelector:@"restart:" ];
    [self createButtonWithTitle:@"score"    andSelector:@"score:"];

    CGSize cs = [[CCDirector sharedDirector] viewSize];
    cs.width  = cs.width  / 2 - self._layoutBox.contentSize.width /2;
    cs.height = cs.height / 2 - self._layoutBox.contentSize.height / 2;
    
    self._layoutBox.position = ccp(cs.width,cs.height);
    [self addChild:self._layoutBox];
    
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

/*
 *==============================================================================
 * Continue button clicked.
 *==============================================================================
 */
-(void) continue: (id) sender
{
    NSLog(@"Continue button has been pressed");
    [[SceneManager instance] changeScene: BTSMainGameContinue];
}

/*
 *==============================================================================
 * Score button clicked.
 *==============================================================================
 */
-(void) score: (id) sender
{
    NSLog(@"Score button has been pressed");
    [[SceneManager instance] changeScene: BTSScoreBoard];
}

@end
