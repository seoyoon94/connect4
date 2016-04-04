//
//  GameScene.m
//  p07-AI
//
//  Created by Brian Kim on 3/22/16.
//  Copyright (c) 2016 bkim35. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene
@synthesize viewController;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    numColumns = 7;
    self.backgroundColor = [SKColor blackColor];
    screenWidth = view.bounds.size.width;
    screenHeight = view.bounds.size.height;
    
    NSLog(@"Screen width: %f", screenWidth);
    NSLog(@"Screen height: %f", screenHeight);
    
//    UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight - 50, 50, 50)];
//    UIImage *moveLeftImage = [UIImage imageNamed:@"concave button.png"];
//    [testButton setImage:moveLeftImage forState:UIControlStateNormal];
//    [testButton addTarget:self action:@selector(NULL) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:testButton];
    
    for(int i = 0; i < numColumns; i++){
        SKSpriteNode *column = [[SKSpriteNode alloc] initWithImageNamed:@"connect4.png"];
        float aspectRatio = screenWidth / screenHeight;
        column.size = CGSizeMake(screenWidth / 9, (screenWidth / 9) * aspectRatio);
        column.position = CGPointMake(screenWidth / 9 + i * column.size.width, screenHeight/2);
        [self addChild:column];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
