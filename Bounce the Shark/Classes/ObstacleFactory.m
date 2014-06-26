//
//  ObstacleFactory.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 21/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ObstacleFactory.h"

@implementation ObstacleFactory {
    BOOL            _debugTmpVar;
    
    // Set true when first obstacle is set.
    BOOL            _firstObstacleSet;
    // Mutable array.
    NSMutableArray *_obstacles;
}

@synthesize physicsWorld      = physicsWorld;
@synthesize firstObstacleXpos = firstObstacleXpos;

@synthesize coral_lg_upper_seed = coral_lg_upper_seed;
@synthesize coral_lg_lower_seed = coral_lg_lower_seed;

@synthesize coral_sm_upper_seed = coral_sm_upper_seed;
@synthesize coral_sm_lower_seed = coral_sm_lower_seed;

@synthesize hook_upper_seed = hook_upper_seed;
@synthesize hook_lower_seed = hook_lower_seed;

const static int CORAL_LG_UPPER_SEED = 4;
const static int CORAL_LG_LOWER_SEED = 1;


const static int CORAL_SM_UPPER_SEED = 3;
const static int CORAL_SM_LOWER_SEED = 1;

const static int HOOK_UPPER_SEED = 3;
const static int HOOK_LOWER_SEED = 1;

const static int RAND_TARGET = 2;


-(id) initWithPhysicsNode : (CCPhysicsNode *) world
{
    if( self != [super init])
        self = nil;
    
    self.physicsWorld = world;
    
    _debugTmpVar = TRUE;
    
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
    
     _obstacles = [NSMutableArray array];
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
            Obstacle *obstacle = [self setUpHookObstacle : firstObstacleXpos];
            if(obstacle != nil)
                [_obstacles addObject:obstacle];
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
-(Obstacle *) setUpHookObstacle : (CGFloat) xpoint
{
    HookObstacle *obstacle = [[HookObstacle alloc] initWithImage];
    [self.physicsWorld addChild: [obstacle getSpriteSheet]];
    
    CGFloat ypoint = [[CCDirector sharedDirector] viewSize].height
            - [obstacle getContentHeight];
    [obstacle setPosition:ccp(xpoint,ypoint)];
    [obstacle setAnchorPoint:CGPointZero];
        
    _firstObstacleSet = FALSE;
    
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
    BOOL rv = [self genObs : self.coral_lg_lower_seed withUpper : self.coral_lg_upper_seed];
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
