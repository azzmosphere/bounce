//
//  ObstacleFactory.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ObstacleFactory.h"

@implementation ObstacleFactory {
    
    // Set true when first obstacle is set.
    BOOL            _firstObstacleSet;
    
    // Mutable array.
    NSMutableArray *_obstacles;
    
    CGFloat         _xWidth;
    CGFloat         _xpos;
}

@synthesize physicsWorld      = physicsWorld;
@synthesize firstObstacleXpos = firstObstacleXpos;

@synthesize coral_lg_upper_seed = coral_lg_upper_seed;
@synthesize coral_lg_lower_seed = coral_lg_lower_seed;

@synthesize coral_sm_upper_seed = coral_sm_upper_seed;
@synthesize coral_sm_lower_seed = coral_sm_lower_seed;

@synthesize hook_upper_seed = hook_upper_seed;
@synthesize hook_lower_seed = hook_lower_seed;

@synthesize coin_upper_seed = coin_upper_seed;
@synthesize coin_lower_seed = coin_lower_seed;

@synthesize gameScene = gameScene;

const static int CORAL_LG_UPPER_SEED = 6;
const static int CORAL_LG_LOWER_SEED = 1;


const static int CORAL_SM_UPPER_SEED = 3;
const static int CORAL_SM_LOWER_SEED = 1;

const static int HOOK_UPPER_SEED = 4;
const static int HOOK_LOWER_SEED = 1;

const static int COIN_UPPER_SEED = 3;
const static int COIN_LOWER_SEED = 1;

// The target value for randomly generated obstacles
const static int RAND_TARGET = 2;

// Maximum obstacles that can appear on screen at once,  this includes
// obstacles that are just off screen.
const static int OBSTACLES_ON_SCREEN = 10;


-(id) initWithPhysicsNode : (CCPhysicsNode *) world
{
    if( self != [super init])
        self = nil;
    
    self.physicsWorld = world;
    
    _firstObstacleSet = FALSE;
    
    // Default position for first obstacle
    firstObstacleXpos = [[CCDirector sharedDirector] viewSize].width +
         ([[CCDirector sharedDirector] viewSize].width * 0.05);
    
    coral_lg_upper_seed = CORAL_LG_UPPER_SEED;
    coral_lg_lower_seed = CORAL_LG_LOWER_SEED;
    coral_sm_lower_seed = CORAL_SM_LOWER_SEED;
    coral_sm_upper_seed = CORAL_SM_UPPER_SEED;
    hook_lower_seed     = HOOK_LOWER_SEED;
    hook_upper_seed     = HOOK_UPPER_SEED;
    coin_lower_seed     = COIN_LOWER_SEED;
    coin_upper_seed     = COIN_UPPER_SEED;
    
     _obstacles = [NSMutableArray array];

    return self;
}

/*
 *==============================================================================
 * This method is called for each update from the game scene,  the first 
 * obstacle is allways a large coral,  this is used to compute the size and
 * padding for all consequent obstacles.
 *
 * After that obstacles will be generated using the xWidth.
 *==============================================================================
 */
-(void) updateObstacles
{
    if (!_firstObstacleSet){
        Obstacle *obstacle = [[CoralSmallObstacle alloc] initWithImageAndPhysicsBody];
        _xWidth   = obstacle.contentSizeInPoints.width;
        _xpos = firstObstacleXpos;
        [self setUpGroundObstacle: _xpos
                     withObstacle: obstacle];
        _firstObstacleSet = TRUE;
        
    }
    
    // Generate obstacles if we have not filled up the array of obstacles on
    // screen,  this is a soft ceiling.
    else if([_obstacles count] < OBSTACLES_ON_SCREEN){
        _xpos += _xWidth;
        [self spawnObstacles : _xpos withUpper : (_xpos + _xWidth)];
    }
    [self removeObstacles];
}


/*
 *==============================================================================
 *==============================================================================
 */
-(void) spawnObstacles : (CGFloat) lower
             withUpper : (CGFloat) upper
{
        CGSize  viewSize = [[CCDirector sharedDirector] viewSize];
        CGFloat       xpoint = lower;
        Coin         *coin   = nil;
        HookObstacle *hook   = [self setUpHookObstacle : xpoint];
        Obstacle     *obstacle = nil;
        if(!_firstObstacleSet){
            xpoint = firstObstacleXpos;
            _firstObstacleSet = TRUE;
        }
            
        if(hook != nil)
            [_obstacles addObject:hook];
        else {
            coin = [self setUpCoin:xpoint withYoint:viewSize.height * 0.8f];
            if(coin != nil)
                 [_obstacles addObject:coin];
        }
            
        if( (obstacle = [self setUpCoralLarge   : xpoint]) != nil )
            [_obstacles addObject:obstacle];
            
        else if ( (obstacle = [self setUpCoralSmall : xpoint]) != nil )
            [_obstacles addObject:obstacle];
        else if (coin == nil) {
            coin = [self setUpCoin:xpoint withYoint:viewSize.height * 0.1f];
            if(coin != nil)
                [_obstacles addObject:coin];
        }
        
        if( (hook != nil && coin == nil) && (viewSize.height -
        (hook.contentSizeInPoints.height + hook.position.y)) > viewSize.height * 0.1f ){
            coin = [self setUpCoin:xpoint withYoint:viewSize.height * 0.9f];
            if(coin != nil)
                [_obstacles addObject:coin];
        }
}

/*
 *==============================================================================
 *==============================================================================
 */
-(void) removeObstacles
{
    NSMutableArray *moveObstacles = [NSMutableArray array];
    
    // Remove obstacles that have left screen.
    for(Obstacle *obstacle in _obstacles){
        CGPoint obstacleWorldPosition =
        [physicsWorld convertToWorldSpace:obstacle.position];
        CGPoint obstacleScreenPosition =
        [gameScene convertToNodeSpace:obstacleWorldPosition];
        
        if (obstacleScreenPosition.x < -obstacle.contentSize.width)
            [moveObstacles addObject:obstacle];
        
    }
    
    for(Obstacle *obstacleToRemove in moveObstacles){
        NSLog(@"Removing obstacle");
        [obstacleToRemove removeFromParent];
        [_obstacles removeObject:obstacleToRemove];

    }
    
}


/*
 *==============================================================================
 *==============================================================================
 */
-(HookObstacle *) setUpHookObstacle : (CGFloat) xpoint
{
    HookObstacle *obstacle = nil;
    
    if([self genObs:hook_lower_seed withUpper:hook_upper_seed]){
        obstacle = [[HookObstacle alloc] initWithImage];
        [self.physicsWorld addChild: [obstacle getSpriteSheet]];
    
        int lower = [[CCDirector sharedDirector] viewSize].height
            - [obstacle getContentHeight];
        int upper = lower + [obstacle getMinContentHeight];        
        int ypoint = lower + arc4random() % (upper - lower);
        
        int xupper = (int)roundf(xpoint) + (int)round(obstacle.contentSizeInPoints.width * 3);
        int xlower = (int)roundf(xpoint);
        int x      = xlower + arc4random() % (xupper - xlower);
        
        NSLog(@"Hook generated with xlower:%d x xupper:%d",xlower, xupper);
        [obstacle setPosition:ccp(x,ypoint)];
        [obstacle setAnchorPoint:CGPointZero];
    }
    
    return obstacle;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(Obstacle *) setUpCoralLarge : (CGFloat) xpoint
{
    BOOL rv = [self genObs : self.coral_lg_lower_seed withUpper : self.coral_lg_upper_seed];
    Obstacle *obstacle = nil;
    if(rv){
        obstacle = [[CoralLargeObstacle alloc] initWithImageAndPhysicsBody];
        [self setUpGroundObstacle: xpoint
                     withObstacle: obstacle];
    }
    return obstacle;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(Obstacle *) setUpCoralSmall : (CGFloat) xpoint
{
    BOOL rv = [self genObs : coral_lg_lower_seed withUpper : coral_lg_upper_seed];
    Obstacle *obstacle = nil;
    if(rv){
        obstacle = [[CoralSmallObstacle alloc] initWithImageAndPhysicsBody];
        [self setUpGroundObstacle: xpoint
                 withObstacle: obstacle];
    }
    return obstacle;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(Coin *) setUpCoin : (CGFloat) xpoint  withYoint : (CGFloat) ypoint
{
    BOOL rv = [self genObs : coin_lower_seed withUpper : coin_upper_seed];
    Coin *obstacle = nil;
    if(rv){
        obstacle = [[Coin alloc] initWithImage];
        int lower   = roundf(xpoint);
        int upper   = lower + roundf(obstacle.contentSizeInPoints.width * 3);
        int rxpoint = lower + arc4random() % (upper - lower);
                             
        [obstacle setPosition:ccp(rxpoint,ypoint)];
        [obstacle setAnchorPoint:CGPointZero];
        [physicsWorld addChild:obstacle];
    }
    return obstacle;
}

/*
 *==============================================================================
 * Return true when a obstacle should be generated.
 *==============================================================================
 */
-(BOOL) genObs : (int) lower withUpper : (int) upper
{
    if( (lower + arc4random() % (upper - lower)) == RAND_TARGET)
        return TRUE;
    return FALSE;
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
