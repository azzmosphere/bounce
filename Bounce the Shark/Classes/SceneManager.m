//
//  SceneManager.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 30/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager


static SceneManager *sceneMgr;

@synthesize scrollSpeed    = scrollSpeed;
@synthesize level          = level;
@synthesize points         = points;
@synthesize totalTime      = totalTime;
@synthesize metresTraveled = metresTraveled;

/*
 *==============================================================================
 * Class constructor,  creates a singleton reference of the class.
 *==============================================================================
 */
+ (SceneManager *)instance
{
    @synchronized(self)
    {
        if (sceneMgr == NULL){
            sceneMgr = [[self alloc] init];
        }
    }
    
    return sceneMgr;
}

/*
 *==============================================================================
 * Class constructor,
 *==============================================================================
 */
-(id) init
{
    self = [super init];
    if(self == nil)
        return self;
    [self resetDefaults];

    return self;
}


-(void) resetDefaults
{
    points      = 0;
    level       = 1;
    totalTime   = 0;
    scrollSpeed = SCROLL_SPEED;
    
}

/*
 *==============================================================================
 * Based on a enumerated returns a scene to the controlling the calling class.
 *==============================================================================
 */
-(CCScene *) getScene : (NSUInteger) scene
{
    CCScene      *trnScene;
    switch(scene){
        case BTSMainGameIntroScene:
            trnScene = [MainGamePlay scene : scrollSpeed];
            break;
        case BTSMainGamePlayScene:
            [self resetDefaults];
            trnScene = [MainGamePlay scene : scrollSpeed];
            break;
        case BTSHeroDiedScene:
            trnScene = [HeroDiedScene scene];
            break;
        case BTSMainGameContinue:
            trnScene = [MainGamePlay scene : scrollSpeed];
            break;
            
    }
    return trnScene;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) changeScene : (NSUInteger) scene
{
    CCScene *newscene = [self getScene:scene];
    [[CCDirector sharedDirector] replaceScene:newscene];
}

@end
