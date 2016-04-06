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
@protocol Connect4Delegate;

@interface GameViewController : UIViewController <Connect4Delegate>
{
    GameScene *scene;
    Connect4 *connect4;
}

- (void)buttonPressed:(UIButton *)sender;
- (void)gameDidEnd:(Connect4 *)connect4;

@end
