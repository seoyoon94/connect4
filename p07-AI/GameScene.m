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
    
    int tempTag = 0;
    for(int i = 0; i < numColumns; i++){
        //Create game board
        SKSpriteNode *column = [[SKSpriteNode alloc] initWithImageNamed:@"connect4.png"];
        column.size = CGSizeMake(screenWidth / 9, (screenWidth/9) * 6.15);
        columnWidth = column.size.width;
        columnHeight = column.size.height;
        column.position = CGPointMake(screenWidth / 9 + i * columnWidth + columnWidth/2, screenHeight/2);
        [self addChild:column];
        
        //Create buttons
        UIButton *columnButton = [[UIButton alloc]initWithFrame:CGRectMake(column.size.width + i * column.size.width, screenHeight/2 + column.size.height/2, columnWidth, columnWidth)];
        buttonWidth = columnButton.bounds.size.width;
        buttonHeight = columnButton.bounds.size.height;
        
        boardBeginX = (screenWidth / 9) + (columnWidth / 2);
        boardBeginY = (screenHeight / 2) + (buttonHeight / 2) - (columnHeight / 2) + 5;
        
        //Set up tags so the View Controller can access the column with the tag number
        columnButton.tag = tempTag;
        tempTag++;
        UIImage *buttonImage = [UIImage imageNamed:@"concave button.png"];
        [columnButton setImage:buttonImage forState:UIControlStateNormal];
        //Once button is pressed, call the buttonPressed method from the View Controller
        [columnButton addTarget:viewController action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:columnButton];
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

-(void)insertPieceInView:(int)column row:(int)row {
    SKSpriteNode *newPiece = [[SKSpriteNode alloc] initWithImageNamed:@"connect4red.png"];
    newPiece.size = CGSizeMake(buttonWidth, buttonHeight);
    newPiece.position = CGPointMake(boardBeginX + (column * buttonWidth), boardBeginY + (row * buttonWidth));
    [self addChild:newPiece];
}

@end
