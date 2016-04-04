//
//  Connect4.m
//  p07-AI
//
//  Created by Brian Kim on 4/4/16.
//  Copyright © 2016 bkim35. All rights reserved.
//

#import "Connect4.h"

@implementation Connect4

@synthesize numColumns;
@synthesize numRows;
@synthesize numPiecesInColumn;

-(void) initConnect4Board {
    [self setNumColumns:7];
    [self setNumRows:6];
    
    //Keep track of the number of pieces in each column. Initialize to 0.
    numPiecesInColumn = [[NSMutableArray alloc] initWithCapacity:numColumns];
    for(int i = 0; i < numColumns; i++){
        [numPiecesInColumn addObject:[NSNumber numberWithInt:0]];
    }
    
    gameBoard = [[NSMutableArray alloc] initWithCapacity:numRows];
    
    //Initialize the 2D array to contain empty pieces
    for (int i = 0; i < numRows; ++i) {
        NSMutableArray *row = [[NSMutableArray alloc] initWithCapacity:numColumns];
        
        for (int j = 0; j < numColumns; ++j) {
            NSNumber *boardInitializer = [NSNumber numberWithInt:EMPTY];
            [row addObject:boardInitializer];
        }
        
        [gameBoard addObject:row];
    }
    

}

@end