//
//  GameViewController.h
//  p07-AI
//

//  Copyright (c) 2016 bkim35. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>


@class GameScene;
@class Connect4;
@class MenuScene;
@protocol Connect4Delegate;

@interface GameViewController : UIViewController <Connect4Delegate>
{
    GameScene *gameScene;
    MenuScene *menuScene;
    Connect4 *connect4;
}

@property BOOL moveInProgress;
@property BOOL gameEnded;
- (void)presentMenu;
- (void)buttonPressed:(UIButton *)sender;
- (void)gameDidEnd:(Connect4 *)connect4 draw:(BOOL)draw;
- (void)callAI;
- (void) gameReset;
- (void) startGame:(int)difficulty;

@end
