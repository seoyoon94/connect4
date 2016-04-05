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
    
    NS_ENUM(NSInteger, Direction){
        RIGHT = 0,
        UP = 1,
        UP_LEFT = 2,
        UP_RIGHT = 3
    };
    
    enum SlotColor currentColor;
    NSMutableArray *gameBoard;
}

@property const int numRows;
@property const int numColumns;
@property const int maxNumPieces;
@property int currentNumPieces;
@property NSMutableArray* numPiecesInColumn;

-(void) initConnect4Board;
-(void) addPieceToBoard:(int)index;

@end
