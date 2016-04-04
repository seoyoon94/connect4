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
@interface GameViewController : UIViewController
{
    GameScene *scene;
    Connect4 *connect4;
}

@end
