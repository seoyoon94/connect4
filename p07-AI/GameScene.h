//
//  GameScene.h
//  p07-AI
//

//  Copyright (c) 2016 bkim35. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"
#import "MenuScene.h"

@interface GameScene : SKScene
{
    int numColumns;
    int numRows;
    float screenWidth, screenHeight;
    float columnWidth, columnHeight;
    float buttonWidth, buttonHeight;
    float boardBeginX, boardBeginY;
}

-(void) insertPieceInView:(int)column
                    row:(int)row
                   player:(int)player;

-(void) clearBoard;
-(void) gameOverAlert:(int)currentColor;
-(void) showButtons;
-(void) hideButtons;

@property GameViewController *viewController;
@property SKView *selfView;
@end
