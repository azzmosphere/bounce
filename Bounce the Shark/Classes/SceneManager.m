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
            
            // Set the defaults
            //sceneMgr._level  = 1;
            //sceneMgr._scroll_speed = SPEED_DELTA;
        }
    }
    
    return sceneMgr;
}

/*
 *==============================================================================
 * Based on a enumerated returns a scene to the controlling the calling class.
 *==============================================================================
 */
-(CCScene *) getScene : (NSUInteger) scene
{
    CCScene *trnScene;
    switch(scene){
        case BTSMainGameIntroScene:
            trnScene = [MainGamePlay scene : SCROLL_SPEED];
            break;
        case BTSMainGamePlayScene:
            trnScene = [MainGamePlay scene : SCROLL_SPEED];
            break;
        case BTSHeroDiedScene:
            trnScene = [HeroDiedScene scene];
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
