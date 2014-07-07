//
//  ScorePersistence.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ScorePersistence.h"

@implementation ScorePersistence {
    NSArray        *_paths;
    NSMutableArray *_scores;
    NSString       *_filePath;
}

-(id) init
{
    self = [super init];
    if(self == nil)
        return self;
    
    _paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES);
    
    if([_paths count] <= 0)
        [NSException raise:@"Could not get document path"
                    format:@"Could not get document path"];
    
    _filePath = [[_paths objectAtIndex:0]
                 stringByAppendingPathComponent:@"bts.out"];
    
    // If path exists read the contents.
    if([[NSFileManager defaultManager] fileExistsAtPath:_filePath]){
        NSLog(@"Reading file %@", _filePath);
        [self readFile];
    }
    else {
        NSLog(@"No file exists at %@", _filePath);
    }
    return self;
}

-(void)readFile
{
    
}

@end
