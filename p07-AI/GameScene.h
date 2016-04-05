//
//  GameScene.h
//  p07-AI
//

//  Copyright (c) 2016 bkim35. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface GameScene : SKScene
{
    int numColumns;
    float screenWidth, screenHeight;
    float columnWidth, columnHeight;
    float buttonWidth, buttonHeight;
    float boardBeginX, boardBeginY;
}

-(void) insertPieceInView:(int)column
                   row:(int)row;

@property GameViewController *viewController;
@end
