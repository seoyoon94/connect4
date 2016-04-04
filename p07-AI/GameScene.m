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
    
    int tempTag = 0;
    for(int i = 0; i < numColumns; i++){
        //Create buttons
        UIButton *testButton = [[UIButton alloc]initWithFrame:CGRectMake(0, screenHeight - 50, 50, 50)];
        //Set up tags so the View Controller can access the column with the tag number
        testButton.tag = tempTag;
        tempTag++;
        UIImage *buttonImage = [UIImage imageNamed:@"concave button.png"];
        [testButton setImage:buttonImage forState:UIControlStateNormal];
        //Once button is pressed, call the buttonPressed method from the View Controller
        [testButton addTarget:viewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:testButton];
        
        //Create game board
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
