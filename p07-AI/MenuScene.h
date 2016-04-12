//
//  MenuScene.h
//  p07-AI
//
//  Created by Seoyoon Park on 4/11/16.
//  Copyright © 2016 bkim35. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"

@interface MenuScene : SKScene{
    float screenWidth, screenHeight;
}

@property GameViewController *viewController;
@property SKView *selfView;

@end
