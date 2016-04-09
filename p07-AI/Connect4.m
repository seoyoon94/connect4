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
@synthesize currentNumPieces;
@synthesize maxNumPieces;
@synthesize delegate;
@synthesize numMovesPlayed;

-(void) initConnect4Board {
    [self setNumColumns:7];
    [self setNumRows:6];
    [self setCurrentNumPieces:0];
    [self setMaxNumPieces:numRows * numColumns];
    [self setNumMovesPlayed:0];
    recursive = NO;
    
    currentColor = RED;
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

-(void) addPieceToBoard:(int)index{
    int rowIndex = [numPiecesInColumn[index] intValue];
    gameBoard[rowIndex][index] = [NSNumber numberWithInt:currentColor];
    numPiecesInColumn[index] = [NSNumber numberWithInt:([numPiecesInColumn[index] intValue]) + 1];
    if([self gameWon] && !self->recursive){
        [delegate gameDidEnd:self];
    } else {
        if(currentColor == RED) {
            currentColor = BLACK;
            numMovesPlayed++;
        } else {
            currentColor = RED;
            numMovesPlayed++;
        }
    }
}

-(bool) gameWon{
    bool retVal = false;
    NSMutableArray *directionList = [[NSMutableArray alloc] initWithCapacity:4];
    [directionList addObject:[NSNumber numberWithInt:RIGHT]];
    [directionList addObject:[NSNumber numberWithInt:UP]];
    [directionList addObject:[NSNumber numberWithInt:UP_LEFT]];
    [directionList addObject:[NSNumber numberWithInt:UP_RIGHT]];
    
    for(int j = 0; j < numRows; j++){
        for(int k = 0; k < numColumns; k++){
            if([gameBoard[j][k] intValue] == currentColor){
                for(int i = 0; i < [directionList count]; i++){
                    retVal = [self gameWonHelper:1 inDirection:(enum Direction)[directionList[i] intValue] inRow:j inColumn:k];
                    if(retVal){
                        return retVal;
                    }
                }
            }
        }
    }
    return retVal;
}

-(bool) gameWonHelper:(int)numConnected
    inDirection:(enum Direction)direction
          inRow:(int)rowIndex
       inColumn:(int)columnIndex{
    bool retVal = false;
    if(numConnected == 5){
        return true;
    }
    
    //Check for edge cases
    if([self isOutOfBounds:rowIndex inColumn:columnIndex] || [gameBoard[rowIndex][columnIndex] intValue] != currentColor){
        return false;
    }
    switch ((int)direction) {
        case RIGHT:
            retVal =[self gameWonHelper:numConnected + 1 inDirection:RIGHT inRow:rowIndex inColumn:columnIndex + 1];
            break;
        case UP:
            retVal = [self gameWonHelper:numConnected + 1 inDirection:UP inRow:rowIndex + 1 inColumn:columnIndex];
            break;
        case UP_LEFT:
            retVal = [self gameWonHelper:numConnected + 1 inDirection:UP_LEFT inRow:rowIndex + 1 inColumn:columnIndex - 1];
            break;
        case UP_RIGHT:
            retVal = [self gameWonHelper:numConnected + 1 inDirection:UP_RIGHT inRow:rowIndex + 1 inColumn:columnIndex + 1];
            break;
            
        default:
            exit(1); //shit is broken
            break;
    }
    return retVal;
}

-(bool) isOutOfBounds:(int)rowIndex
             inColumn:(int)columnIndex{
    if(rowIndex == numRows || columnIndex < 0 || columnIndex == numColumns){
        return true;
    }
    return false;
}

-(void) clearBoard{
    for(int i = 0; i < numRows; i++){
        for(int j = 0; j < numColumns; j++){
            gameBoard[i][j] = [NSNumber numberWithInt:EMPTY];
        }
    }
    
    for(int i = 0; i < numColumns; i++){
        numPiecesInColumn[i] = [NSNumber numberWithInt:0];
    }
    
    currentColor = RED;
    numMovesPlayed = 0;
}

/** Beginning of minimax algorithm with alpha beta pruning **/
-(int)miniMaxAlphaBeta:(Connect4 *)state
                player:(enum SlotColor)player
                 depth:(int)depth
                 alpha:(int)alpha
                  beta:(int)beta
                 count:(int)count {
    int retVal;
   
    if (count == 5) {
        if ((depth == 0) && ![state gameWon]) {
            return 0;
        }
        if ((depth == 0) && [state gameWon]) {
            int score = 0;
            if(player == RED){
                score = -50 + (42 - depth);
            }
            else{
                score = 50 - (42 - depth);
            }
            return score;
        }
        if ([state gameWon]) {
            int score = 0;
            if(player == RED){
                score = -50 + (42 - depth);
            }
            else{
                score = 50 - (42 - depth);
            }
            return score;
        }
        
        return (arc4random() % numColumns);
    }

    NSArray *moves = [state availableMoves];
    for (int move = 0; move < [moves count]; move++) {
        Connect4 *nextState = [state nextStateWithMove:[moves[move] intValue]];
        int score = [state miniMaxAlphaBeta:nextState player:nextState->currentColor depth:depth - 1 alpha:alpha beta:beta count:(count + 1)];
        
        if (player == BLACK) {
            if (score > alpha) {
                alpha = score;
            }
        } else {
            if (score < beta) {
                beta = score;
            }
        }
        
        if (alpha >= beta) {
            break;
        }
    }
    
    if (player == BLACK) {
        retVal = alpha;
    } else {
        retVal = beta;
    }
    return retVal;
}

/*Find best possible move of current state */
-(int)findBestMove{
    int bestMove = -1;
    int alpha = -50;
    int beta = 50;
    NSArray *moveList = [self availableMoves];
    for(int move = 0; move < [moveList count]; move++){
        Connect4 * nextState = [self nextStateWithMove:[moveList[move] intValue]];
        int sc = [self miniMaxAlphaBeta:nextState player:((Connect4 *)nextState)->currentColor depth:(42 - nextState.numMovesPlayed) alpha:alpha beta:beta count:0];
        NSLog(@"sc: %d", sc);
        if(sc > alpha) {
            bestMove = move;
            alpha = sc;
        }
    }
    return bestMove;
}

/* Returns the next game state after the next possible move has been played */
-(Connect4 *)nextStateWithMove:(int)move{
    Connect4 *nextState = [self copy];
    [nextState addPieceToBoard:move];
    return nextState;
}

/* Returns the list of remaining available moves */
-(NSMutableArray *)availableMoves{
    NSMutableArray *moveList = [[NSMutableArray alloc] init];
    for(int i = 0; i < numColumns; i++){
        if([numPiecesInColumn[i] intValue] < numRows){
            [moveList addObject:[NSNumber numberWithInt:i]];
        }
    }
    return moveList;
}

-(id)copyWithZone:(NSZone *)zone {
    Connect4 *copiedInstance = [[Connect4 alloc] init];
    
    copiedInstance->currentColor = self->currentColor;
    copiedInstance->gameBoard = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self->gameBoard count]; ++i) {
        NSMutableArray *copiedRow = [[NSMutableArray alloc] initWithArray:(self->gameBoard)[i] copyItems:YES];
        [copiedInstance->gameBoard addObject:copiedRow];
    }
    copiedInstance.numMovesPlayed = self.numMovesPlayed;
    copiedInstance.numRows = self.numRows;
    copiedInstance.numColumns = self.numColumns;
    copiedInstance.maxNumPieces = self.maxNumPieces;
    copiedInstance.currentNumPieces = self.currentNumPieces;
    copiedInstance.numPiecesInColumn = [[NSMutableArray alloc] initWithArray:self->numPiecesInColumn copyItems:YES];
    copiedInstance.delegate = self.delegate;
    copiedInstance->recursive = YES;
    
    return copiedInstance;
}

@end