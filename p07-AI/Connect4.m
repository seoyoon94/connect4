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

-(void) initConnect4Board {
    [self setNumColumns:7];
    [self setNumRows:6];
    [self setCurrentNumPieces:0];
    [self setMaxNumPieces:numRows * numColumns];
    
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
    if([self gameWon]){
        NSLog(@"Hello");
    }
    if(currentColor == RED){
        currentColor = BLACK;
    }
    else{
        currentColor = RED;
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
            //ERROR: Slot color given value of 34
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

@end