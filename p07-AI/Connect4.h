//
//  Connect4.h
//  p07-AI
//
//  Created by Brian Kim on 4/4/16.
//  Copyright © 2016 bkim35. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameViewController.h"

@protocol Connect4Delegate

-(void)gameDidEnd:(Connect4 *)connect4;
//-(void)callAIMove:(Connect4 *)connect4;

@end

@interface Connect4 : NSObject <NSCopying>
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
    
    NSMutableArray *gameBoard;
    BOOL recursive;
}

@property int difficulty;
@property enum SlotColor currentColor;
@property int numMovesPlayed;
@property const int numRows;
@property const int numColumns;
@property const int maxNumPieces;
@property int currentNumPieces;
@property NSMutableArray* numPiecesInColumn;
@property (weak, nonatomic) id delegate;

-(void) initConnect4Board;
-(void) addPieceToBoard:(int)index;
-(void) clearBoard;
-(int) findBestMove;
-(id)copyWithZone:(NSZone *)zone;

@end
