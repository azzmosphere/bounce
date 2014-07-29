//
//  ScorePersistence.m
//  Bounce the Shark
//
//  Created by Aaron Spiteri on 6/07/2014.
//  Copyright (c) 2014 AZZMOSPHERE. All rights reserved.
//

#import "ScorePersistence.h"

@implementation ScorePersistence {
    NSMutableArray *_scores;
    NSString       *_filePath;
}

-(id) init
{
    self = [super init];
    if(self == nil)
        return self;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                NSUserDomainMask, YES);
    NSFileManager *fmngr = [NSFileManager defaultManager];
    
    if([paths count] <= 0)
        [NSException raise:@"Could not get document path"
                    format:@"Could not get document path"];
    
    _filePath = [[paths objectAtIndex:0]
                 stringByAppendingPathComponent:@"bts_score.plist"];
    
    // If path exists read the contents.
    if([fmngr fileExistsAtPath:_filePath]){
        NSLog(@"Reading file %@", _filePath);
        [self readFile];
    }
    else {
        NSLog(@"No file exists at %@ - creating file", _filePath);
        if( ![fmngr createFileAtPath:_filePath contents:nil attributes:nil ] )
            [NSException raise:@"Could not create file"
                        format:@"Could not create persistence file"];
            
    }
    return self;
}

-(void) readFile
{
    _scores = [NSArray arrayWithContentsOfFile:_filePath];
    
    for(NSDictionary *dict in _scores){
        NSLog(@"%@ : %@ : %@ : %@",
              [dict objectForKey:@"level"],
              [dict objectForKey:@"points"],
              [dict objectForKey:@"totalTime"],
              [dict objectForKey:@"metresTraveled"]
              );
    }
}

-(void) writeToPresistence :  (NSUInteger) level
                withScore :  (NSUInteger) points
            withTotalTime : (CGFloat) totalTime
       withMetresTraveled : (NSUInteger) metresTraveled
{
    NSLog(@"writing score to persistence device file %@", _filePath);
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSNumber numberWithUnsignedInteger:level] , @"level",
                          [NSNumber numberWithUnsignedInteger:points], @"points",
                          [NSNumber numberWithFloat:totalTime]       , @"totalTime",
                          [NSNumber numberWithUnsignedInteger:metresTraveled], @"metresTraveled",
                          nil];
    [_scores addObject:dict];
    
    if([_scores writeToFile:_filePath atomically:YES ] == FALSE){
        NSLog(@"could not write to file %@", _filePath);
    }
}

@end
