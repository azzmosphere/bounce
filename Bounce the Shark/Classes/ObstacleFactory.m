//
//  ObstacleFactory.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ObstacleFactory.h"

@implementation ObstacleFactory {
    BOOL _debugTmpVar;
    
    // Set true when first obstacle is set.
    BOOL _firstObstacleSet;
}

@synthesize physicsWorld      = physicsWorld;
@synthesize firstObstacleXpos = firstObstacleXpos;


-(id) initWithPhysicsNode : (CCPhysicsNode *) world
{
    // randomly add coral
    //CoralSmallObstacle *coral1 = [[CoralSmallObstacle alloc] initWithImageAndPhysicsBody];
    //CoralLargeObstacle *obstacle = [[CoralLargeObstacle alloc] initWithImageAndPhysicsBody];
    //
    //Coin *obstacle = [[Coin alloc] initWithImage];
    //[obstacle setPosition:ccp(900,0)];
    //[obstacle setAnchorPoint:ccp(0,0)];
    
    // Non animated obstacles get attached directly
    //[world addChild: obstacle];
    
    // attach the sprite sheet of a animated obstacle.
    //
    
    if( self != [super init])
        self = nil;
    
    self.physicsWorld = world;
    
    _debugTmpVar = TRUE;
    
    _firstObstacleSet = FALSE;
    
    // Default position for first obstacle
    firstObstacleXpos = [[CCDirector sharedDirector] viewSize].width +
         ([[CCDirector sharedDirector] viewSize].width * 0.05);
    
    
    return self;
}


/*
 *==============================================================================
 *==============================================================================
 */
-(void) updateObstacles
{
    if(_debugTmpVar){
        if(!_firstObstacleSet){
            [self setUpHookObstacle : firstObstacleXpos];
            [self setUpCoralLarge   : firstObstacleXpos];
            
            [self setUpHookObstacle : firstObstacleXpos + firstObstacleXpos];
            [self setUpCoralSmall   : firstObstacleXpos + firstObstacleXpos];
            
            _debugTmpVar =FALSE;
        }
        
    }
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) setUpHookObstacle : (CGFloat) xpoint
{
    HookObstacle *obstacle = [[HookObstacle alloc] initWithImage];
    [self.physicsWorld addChild: [obstacle getSpriteSheet]];
    
    CGFloat ypoint = [[CCDirector sharedDirector] viewSize].height
            - [obstacle getContentHeight];
    [obstacle setPosition:ccp(xpoint,ypoint)];
    [obstacle setAnchorPoint:CGPointZero];
        
    _firstObstacleSet = FALSE;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) setUpCoralLarge : (CGFloat) xpoint
{
    [self setUpGroundObstacle: xpoint
                 withObstacle: [[CoralLargeObstacle alloc] initWithImageAndPhysicsBody]];
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) setUpCoralSmall : (CGFloat) xpoint
{
    [self setUpGroundObstacle: xpoint
                 withObstacle: [[CoralSmallObstacle alloc] initWithImageAndPhysicsBody]];
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) setUpGroundObstacle : (CGFloat) xpoint
               withObstacle : (Obstacle *)obstacle
{
    CGFloat ypoint = 0.f;
    
    [obstacle setPosition:ccp(xpoint,ypoint)];
    [obstacle setAnchorPoint:CGPointZero];
    
    [self.physicsWorld addChild: obstacle];
}

@end
