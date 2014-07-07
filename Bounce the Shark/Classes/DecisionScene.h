//
//  DecisionScene.h
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "CCButton.h"
#import "CCSprite.h"
#import "CCLayoutBox.h"
#import "CCScene.h"

@interface DecisionScene : CCScene

@property (nonatomic, retain) CCLayoutBox *_layoutBox;

+(CCScene *)  scene;
-(id)         init;
-(CCButton *) createButtonWithTitle :(NSString *) title
                        andSelector :(NSString *) selector;

@end
