//
//  Connect4.h
//  p07-AI
//
//  Created by Brian Kim on 4/4/16.
//  Copyright © 2016 bkim35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@interface Connect4 : NSObject
{
    NS_ENUM(NSInteger, SlotColor){
        RED = 0,
        BLACK = 1,
        EMPTY = 2
    };
    
    NSMutableArray *gameBoard;
    NSMutableArray *numPiecesInColumn;
}

@property const int numRows;
@property const int numColumns;

-(void) initConnect4Board;

@end
