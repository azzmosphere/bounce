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
    CCSprite      *_floor1;
    CCSprite      *_floor2;
    NSArray       *_floor;
    
    CCSprite      *_bg1;
    CCSprite      *_bg2;
    NSArray       *_bg;
    CCPhysicsNode *_physicsWorld;
    
    SharkHero     *_shark;
    
    CGFloat scrollSpeed;
}


// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (MainGamePlay *)scene
{
    return [[self alloc] init];
}


-(id) init
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
    [self setFloor];
    [self addChild:_physicsWorld];

    // Done in scene
    _shark = [[SharkHero alloc] initWithImage];
    
    [_physicsWorld addChild: [_shark getSpriteSheet]];
    CGSize viewSize = [[CCDirector sharedDirector] viewSize];
    _shark.position = ccp(viewSize.width * 0.2f, viewSize.height/2);
    
    
    _physicsWorld.gravity = ccp(0,-50);
    scrollSpeed = 80.f;
    return self;
}

-(void) setFloor
{
    _floor1 = [self createFloorTile:0.f];
    _floor2 = [self createFloorTile:_floor1.contentSize.width];
    _floor = [NSArray arrayWithObjects:_floor1,_floor2, nil];
    [_physicsWorld addChild:_floor1];
    [_physicsWorld addChild:_floor2];
}

-(CCSprite *) createFloorTile : (CGFloat) xpoint
{
    /* This should scale the floor correctly. */
    CCSprite * tile = [CCSprite spriteWithImageNamed:@"oceanfloortile.png"];
    
    [tile setPosition:ccp(xpoint,0)];
    [tile setAnchorPoint:CGPointMake(0, 0)];
    
    tile.physicsBody = [CCPhysicsBody bodyWithRect: CGRectMake(
                                                              CGPointZero.x,
                                                              CGPointZero.y,
                                                              tile.contentSize.width,
                                                              tile.contentSize.height * 0.05)
                                      cornerRadius:0];
    tile.physicsBody.type = CCPhysicsBodyTypeStatic;
    
    NSLog(@"Bounding body = %f x %f x %f x %f",
          tile.boundingBox.origin.x,
          tile.boundingBox.origin.y,
          tile.boundingBox.size.width,
          tile.boundingBox.size.height);
    
    return tile;
}


-(void) update:(CCTime)delta
{    
    _physicsWorld.position = ccp(((_physicsWorld.position.x - (scrollSpeed *delta)) + 1), _physicsWorld.position.y);
    
    [self updateScrollingImage: _floor];
    
    for (CCSprite *bg in _bg){
        [bg setPosition:CGPointMake(bg.position.x - 1, bg.position.y)];
        
        if(bg.positionInPoints.x <= (-1 * bg.contentSizeInPoints.width)){
            [bg setPosition:ccp(bg.contentSize.width,bg.position.y)];
            bg.position = ccp(bg.position.x + 2 * bg.contentSize.width, bg.position.y);
        }
    }
    
    _shark.position = ccp(_shark.position.x + (delta * scrollSpeed) -1,_shark.position.y);
    
    if(_shark.position.y < 71)
       NSLog(@"Shark position %f x %f", _shark.position.x, _shark.position.y);
}

-(void) updateScrollingImage : (NSArray *) clamps;
{
    for (CCSprite *clamp in clamps) {
        CGPoint groundWorldPosition = [_physicsWorld
                                       convertToWorldSpace:clamp.position];
        CGPoint groundScreenPosition = [self
                                        convertToNodeSpace:groundWorldPosition];
        if (groundScreenPosition.x <= (-1 * clamp.contentSize.width )){
            clamp.position = ccp(clamp.position.x + 2 * clamp.contentSize.width, clamp.position.y);
            
        }
    }
}



@end
