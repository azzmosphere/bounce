//
//  DecisionScene.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "DecisionScene.h"

@implementation DecisionScene

@synthesize _layoutBox = _layoutBox;

-(id) init
{
    self = [super init];
    
    if( self == nil )
        return self;
    
    self._layoutBox  = [[CCLayoutBox alloc] init];
    
    self.userInteractionEnabled = TRUE;
    
    // Create the background.
    CCScene *scene = [CCSprite spriteWithImageNamed:@"ocean.png"];
    [scene setAnchorPoint:CGPointZero];
    [self addChild:scene];
    
    // Create layoutbox for background.
    _layoutBox.direction = CCLayoutBoxDirectionVertical;
    [_layoutBox setAnchorPoint:CGPointZero];
    
    return self;    
}

/*
 *==============================================================================
 * Create a instance of the scene
 *==============================================================================
 */
+ (CCScene *)scene
{
    return [[self alloc] init];
}

/*
 *==============================================================================
 * Create a button object and attache it to the layout body.
 *==============================================================================
 */
-(CCButton *) createButtonWithTitle :(NSString *) title
                        andSelector :(NSString *) selector
{
    CCButton *button = [[CCButton alloc] initWithTitle:title
                                              fontName:@"Arial"
                                              fontSize:14];
    [button setAnchorPoint:CGPointZero];
    [self._layoutBox addChild:button];
    
    // Attach the selector to the button, this will delegate back to the
    // scene
    
    SEL sel =  NSSelectorFromString(selector);
    [button setTarget:self selector:sel];
    
    return button;
}



@end
