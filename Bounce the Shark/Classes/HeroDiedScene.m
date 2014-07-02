//
//  HeroDiedScene.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 1/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "HeroDiedScene.h"

@implementation HeroDiedScene {
    CCLayoutBox *_layoutBox;
    CCButton    *_continue;
    CCButton    *_restart;
}

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
    
    self.userInteractionEnabled = TRUE;
    
    // Create the background.
    CCScene *scene = [CCSprite spriteWithImageNamed:@"ocean.png"];
    [scene setAnchorPoint:CGPointZero];
    [self addChild:scene];

    // Create layoutbox for background.
    _layoutBox = [[CCLayoutBox alloc] init];
    _layoutBox.direction = CCLayoutBoxDirectionVertical;
    [_layoutBox setAnchorPoint:CGPointZero];
    
    //Create buttons
    _continue = [self createButtonWithTitle:@"continiue"];
    _restart  = [self createButtonWithTitle:@"restart"];

    CGSize cs = [[CCDirector sharedDirector] viewSize];
    cs.width  = cs.width  / 2 - _layoutBox.contentSize.width /2;
    cs.height = cs.height / 2 - _layoutBox.contentSize.height / 2;
    
    _layoutBox.position = ccp(cs.width,cs.height);
    [self addChild:_layoutBox];
    
    return self;
}

/*
 *==============================================================================
 * Create a instance of the scene
 *==============================================================================
 */
+ (HeroDiedScene *)scene
{
    return [[self alloc] init];
}

/*
 *==============================================================================
 * Create a button object and attache it to the layout body.
 *==============================================================================
 */
-(CCButton *) createButtonWithTitle :(NSString *) title
{
    CCButton *button = [[CCButton alloc] initWithTitle:title
                                       fontName:@"Arial"
                                       fontSize:14];
    [button setAnchorPoint:CGPointZero];
    [_layoutBox addChild:button];
    
    // Attach the selector to the button, this will delegate back to the
    // scene
    [button setTarget:self selector:@selector(title)];
    
    return button;
}

-(void) restart: (id) sender
{
    NSLog(@"Restart button has been pressed");
}

-(void) continue: (id) sender
{
    NSLog(@"Continue button has been pressed");
}

@end
