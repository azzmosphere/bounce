//
//  MainGamePlay.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 18/06/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

// Use CGPointZero for getting the coordinates for physicalBodies.  This may
// also be good for anchors and other things as well.  Since it can change
// when the API changes.

#import "MainGamePlay.h"

@implementation MainGamePlay {
    CCSprite        *_floor1;
    CCSprite        *_floor2;
    NSArray         *_floor;
    
    CCSprite        *_bg1;
    CCSprite        *_bg2;
    NSArray         *_bg;
    
    CCSprite        *_roof1;
    CCSprite        *_roof2;
    NSArray         *_roof;
    
    CCPhysicsNode   *_physicsWorld;
    
    SharkHero       *_shark;
    
    ObstacleFactory *_obstacleFactory;
    CGPoint         _heroOrigPos;
    NSUInteger      _score;
    CCLayoutBox    *_layoutBox;
    
    CCLabelTTF     *_scoreLbl;
    CCLabelTTF     *_totalTimeLbl;

}

@synthesize _totalTime      = _totalTime;
@synthesize _scrollSpeed    = _scrollSpeed;
@synthesize _metresTraveled = _metresTraveled;

// DEBUG flag, when set to on will draw frames around physics object
static const BOOL DEBUG_MODE = FALSE;


// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MainGamePlay *)scene : (CGFloat) scrollSpeed
{
    return [[self alloc] init : scrollSpeed];
}

/*
 *==============================================================================
 * Constructor
 *==============================================================================
 */
-(id) init : (CGFloat) scrollSpeed
{
    self = [super init];
    if(self == nil)
        return nil;
    
    self.userInteractionEnabled = TRUE;
    
    _bg1 = [CCSprite spriteWithImageNamed:@"ocean.png"];
    _bg2 = [CCSprite spriteWithImageNamed:@"ocean.png"];

    [_bg1 setAnchorPoint:CGPointMake(0, 0)];
    [_bg1 setPosition:ccp(0,0)];
    
    [_bg2 setAnchorPoint:CGPointMake(0, 0)];
    [_bg2 setPosition:ccp(_bg1.contentSizeInPoints.width,0)];
    _bg = [NSArray arrayWithObjects:_bg1,_bg2, nil];
    
    [self addChild:_bg1];
    [self addChild:_bg2];

    _physicsWorld = [CCPhysicsNode node];
    [_physicsWorld setDebugDraw:DEBUG_MODE];
    _floor = [self setFloor];
    _roof  = [self setRoof];
    [self addChild:_physicsWorld];

    // Done in scene
    _shark = [[SharkHero alloc] initWithImage];
    
    [_physicsWorld addChild: [_shark getSpriteSheet]];
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    _shark.position = ccp(viewSize.width * 0.2f, viewSize.height/2);
    
    
    _physicsWorld.gravity = ccp(0,-800);
    
    
    _heroOrigPos = [_physicsWorld convertToWorldSpace: _shark.position];
    
    _physicsWorld.collisionDelegate = self;
    _obstacleFactory = [[ObstacleFactory alloc]
             initWithPhysicsNode: _physicsWorld];
    _obstacleFactory.gameScene = self;
    
    // one meter is the width of the shark object.
    SceneManager *smg = [SceneManager instance];
    _scrollSpeed    = smg.scrollSpeed;
    _metresTraveled = smg.metresTraveled;
    _totalTime      = smg.totalTime;
    _score          = smg.points;
    
    [self initDisplayBoard];

    return self;
}



/*
 *==============================================================================
 * Create the initilisation board
 *==============================================================================
 */
-(void) initDisplayBoard
{
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    NSDictionary   *attrsDictionary = [NSDictionary
                                       dictionaryWithObject:[UIFont fontWithName:@"Arial"
                                                                            size:20.0f]
                                                    forKey:NSFontAttributeName];
    _layoutBox = [[CCLayoutBox alloc] init];
    _layoutBox.direction = CCLayoutBoxDirectionHorizontal;
    _layoutBox.spacing = 5.f;
    
    [_layoutBox setPosition:ccp(viewSize.width * 0.90, viewSize.height * 0.95)];
    
    CCSprite *coinlbl = [[CCSprite alloc] initWithImageNamed:@"coinlbl.png"];
    [_layoutBox addChild:coinlbl];
    
    _scoreLbl = [[CCLabelTTF alloc] initWithAttributedString:
                 [[NSAttributedString alloc] initWithString:[NSString
                                           stringWithFormat:@"%lu",(unsigned long)_score]
                                                  attributes:attrsDictionary]
                            ];
    _scoreLbl.anchorPoint = CGPointZero;
    [_layoutBox addChild:_scoreLbl];

    NSDictionary   *attrsDict = [NSDictionary
                                       dictionaryWithObject:[UIFont fontWithName:@"Courier New"
                                                                            size:20.0f]
                                       forKey:NSFontAttributeName];
    CCLabelTTF *timeLbl = [[CCLabelTTF alloc] initWithAttributedString:
                          [[NSAttributedString alloc] initWithString:@"T" attributes:attrsDict]
    ];
    timeLbl.colorRGBA = [CCColor colorWithRed:0.0 green:0.0 blue:0.0];
    [_layoutBox addChild:timeLbl];
    
    _totalTimeLbl = [[CCLabelTTF alloc] initWithAttributedString:
                     [[NSAttributedString alloc] initWithString:[NSString
                                                                 stringWithFormat:@"%lu",(unsigned long)_metresTraveled]
                                                     attributes:attrsDictionary]
                     ];
    [_layoutBox addChild:_totalTimeLbl];
    [self addChild:_layoutBox];

}


// These routines need to move into there own class that handles
// Floor and adds the extra code for setting up physics.
-(NSArray *) setFloor
{
    _floor1 = [self createFloorTile:0.f];
    _floor2 = [self createFloorTile:_floor1.contentSize.width];
    return [self setClamp:_floor1
        withClamp2:_floor2
         withArray:_floor];
}

/*
 *==============================================================================
 * Create the floor tiles
 *==============================================================================
 */
-(CCSprite *) createFloorTile : (CGFloat) xpoint
{
    CCSprite *tile = [self createClamp:@"oceanfloortile.png"
                           withXpoint:ccp(xpoint,0.f)
                      withHeightOffset:0.05f];
    return tile;
}

// These routines need to move into there own class that handles
// Roof and adds the extra code for setting up physics.
-(NSArray *) setRoof
{
    _roof1 = [self createRoofTile:0.f];
    _roof2 = [self createRoofTile:_roof1.contentSize.width];
    return [self setClamp : _roof1
        withClamp2 : _roof2
         withArray : _roof];
}

/*
 *==============================================================================
 * Create roof tile
 *==============================================================================
 */
-(CCSprite *) createRoofTile : (CGFloat) xpoint
{
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    CCSprite *tile = [self createClamp : @"roof.png"
                            withXpoint : ccp(xpoint,viewSize.height)
                      withHeightOffset : 1.0f];
    return tile;
}



/*
 *=============================================================================
 * Create a floor or roof clamp (tile).  The offset is the height expressed
 * in points from bottom left corner,  
 *
 * NOTE:
 *    offset = 0 will cause it to have a offset at the bottom only (this is ok
 *               ok for the roof.
 *    offset = 1 will mean that the height is exactly the same as the content
 *               (boundingBox) height.
 *    any value between 0 to 1 will be the percentile used for the offset.
 *=============================================================================
 */
-(CCSprite *) createClamp   : (NSString *) imageFile
               withXpoint   : (CGPoint)    spritePosition
           withHeightOffset : (CGFloat)    heightOffset
{
    CCSprite * tile = [CCSprite spriteWithImageNamed:imageFile];
    
    [tile setPosition:spritePosition];
    [tile setAnchorPoint:CGPointMake(0, 0)];
    
    tile.physicsBody = [CCPhysicsBody bodyWithRect: CGRectMake(
                                                               CGPointZero.x,
                                                               CGPointZero.y,
                                                               tile.contentSize.width,
                                                               tile.contentSize.height * heightOffset)
                                      cornerRadius:0];
    tile.physicsBody.type = CCPhysicsBodyTypeStatic;
    
    NSLog(@"Bounding body = %f x %f x %f x %f for '%@'",
          tile.boundingBox.origin.x,
          tile.boundingBox.origin.y,
          tile.boundingBox.size.width,
          tile.boundingBox.size.height,
          imageFile);
    
    return tile;
}

/*
 *==============================================================================
 * Create the clamps
 *==============================================================================
 */
-(NSArray *) setClamp : (CCSprite *) clamp1
      withClamp2 : (CCSprite *) clamp2
       withArray : (NSArray *)  array
{
    array = [NSArray arrayWithObjects:clamp1,clamp2, nil];
    [_physicsWorld addChild:clamp1];
    [_physicsWorld addChild:clamp2];
    
    NSLog(@"%lu elements in clamp array", (unsigned long)[array count]);
    
    return array;
}

/*
 *==============================================================================
 * Update delegate
 *==============================================================================
 */
-(void) update:(CCTime)delta
{
    [self setCameraPosition : delta];
    
    [self updateScrollingImage: _floor  withDebugTitle : @"_floor"];
    [self updateScrollingImage: _roof   withDebugTitle : @"_roof"];
    
    
    for (CCSprite *bg in _bg){
        [bg setPosition:CGPointMake(bg.position.x - 1, bg.position.y)];
        
        if(bg.position.x <= (-1 * bg.contentSize.width)){
            NSLog(@"background screen: position = %f", bg.position.x);
            [bg setPosition: ccp(bg.position.x + 2 * bg.contentSize.width, bg.position.y)];
            NSLog(@"background screen: position = %f", bg.position.x);
        }
    }
    
    [_obstacleFactory updateObstacles];
    _totalTime += delta;
    NSInteger metresTraveled = (NSInteger) roundf((_totalTime * (_scrollSpeed / 2))  / _shark.contentSize.width );
    
    // Update the meters travelled only whne it has actually changed, this is
    // to stop drawing on the screen to regularly.
    if(metresTraveled != _metresTraveled){
        _metresTraveled = metresTraveled;
        [_totalTimeLbl setFontName:@"Courier New"];
        [_totalTimeLbl setFontSize:20.0f];
        [_totalTimeLbl setString:[NSString stringWithFormat:@"%lu",(unsigned long)_metresTraveled]];
    }

}

/*
 *==============================================================================
 * Update the scrolling images. This rotates the  
 *==============================================================================
 */
-(void) updateScrollingImage : (NSArray *) clamps
              withDebugTitle : (NSString *) debugString;
{
    for (CCSprite *clamp in clamps) {
        CGPoint groundWorldPosition = [_physicsWorld
                                       convertToWorldSpace:clamp.position];
        CGPoint groundScreenPosition = [self
                                        convertToNodeSpace:groundWorldPosition];
        
        if (groundScreenPosition.x <= (-1 * clamp.contentSize.width )){
            clamp.position = ccp(clamp.position.x + 2 * clamp.contentSize.width, clamp.position.y);
            NSLog(@"Debug string : %@ - xposition : %f", debugString, clamp.position.x);
        }
    }
}

-(void)touchBegan:(UITouch *)touch
        withEvent:(UIEvent *)event
{
    [_shark screenTouched];
}

/*
 *==============================================================================
 * Set the camera position.
 *==============================================================================
 */
-(void)setCameraPosition : (CCTime) delta
{
    CGPoint heroPos   = [_physicsWorld convertToWorldSpace: _shark.position];
    CGFloat thresHold = 200;
    
    if( heroPos.x < (_heroOrigPos.x - thresHold) ){
        _physicsWorld.position = ccp((_physicsWorld.position.x + 1), _physicsWorld.position.y);
        NSLog(@"hero is below thresold : %f",heroPos.x);
    }
    else {
        _shark.position = ccp(_shark.position.x + (delta * _scrollSpeed) -1,_shark.position.y);
        _physicsWorld.position = ccp(((_physicsWorld.position.x - (_scrollSpeed *delta)) + 1), _physicsWorld.position.y);
    }
}

/*
 *==============================================================================
 *==============================================================================
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
                          hero:(SharkHero *)hero
                          coral_small:(CoralSmallObstacle *)coral
{
    NSLog(@"Coral Hit");
    [_shark neutralCollision];
    
    return TRUE;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
                          hero:(SharkHero *)hero
                   coral_large:(CoralLargeObstacle *)coral
{
    NSLog(@"Coral Hit");
    [_shark neutralCollision];
    
    return TRUE;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
                          hero:(SharkHero *)hero
                          coin:(Coin *)coin {
    NSLog(@"Coin Hit");
    
    [_physicsWorld removeChild:coin];
    [_shark positiveCollision];
    _score += coin.scoreweight;
    
    
    NSLog(@"score %lu", (unsigned long)_score);
    [_scoreLbl setFontName:@"Ariel"];
    [_scoreLbl setFontSize:20.0f];
    [_scoreLbl setString:[NSString stringWithFormat:@"%lu",(unsigned long)_score]];

    
    // Update the transition manager at this point,  that we have just hit
    // a coint.  It will be up to the transition manager to decide what happens
    // in terms of benefit for hitting a coin.
    
    SceneManager *scnMgr  = [SceneManager instance];
    scnMgr.points         = _score;
    scnMgr.totalTime      = _totalTime;
    scnMgr.metresTraveled = _metresTraveled;

    
    return TRUE;
}

/*
 *==============================================================================
 *==============================================================================
 */
-(BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair
                          hero:(SharkHero *)hero
                          hook:(HookObstacle *)hook
{
    NSLog(@"Hook Hit");
    [_shark negativeCollision];
    
    [[SceneManager instance] changeScene:BTSHeroDiedScene];
    
    return TRUE;
}


@end
