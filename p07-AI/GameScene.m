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
@synthesize selfView;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    screenWidth = view.bounds.size.width;
    screenHeight = view.bounds.size.height;
    selfView = self.view;
    
    numColumns = 7;
    numRows = 6;
    self.backgroundColor = [SKColor grayColor];
    SKSpriteNode *title = [[SKSpriteNode alloc] initWithImageNamed:@"title.png"];
    title.size = CGSizeMake(selfView.frame.size.width, title.size.height);
    title.position = CGPointMake(title.size.width / 2, 2 * screenHeight / 3 + title.size.height);
    [self addChild:title];
    
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
        
        //Set up tags so the sView Controller can access the column with the tag number
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

-(void)insertPieceInView:(int)column
                     row:(int)row
                  player:(int)player{
    if(player == 0){
        SKSpriteNode *newPiece = [[SKSpriteNode alloc] initWithImageNamed:@"connect4red.png"];
        newPiece.name = @"Red Piece";
        newPiece.size = CGSizeMake(buttonWidth, buttonHeight);
        newPiece.position = CGPointMake(boardBeginX + (column * buttonWidth), boardBeginY + (row * buttonWidth));
        [self addChild:newPiece];
    }
    else{
        SKSpriteNode *newPiece = [[SKSpriteNode alloc] initWithImageNamed:@"connect4black.png"];
        newPiece.name = @"Black Piece";
        newPiece.size = CGSizeMake(buttonWidth, buttonHeight);
        newPiece.position = CGPointMake(boardBeginX + (column * buttonWidth), boardBeginY + (row * buttonWidth));
        [self addChild:newPiece];
    }
}

-(void)clearBoard{
    [self enumerateChildNodesWithName:@"//Red Piece" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"//Black Piece" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    
    [self hideButtons];
}

-(void)showButtons {
    for (UIView* subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]])
            subView.hidden = NO;
    }
}

-(void)hideButtons {
    for (UIView* subView in self.view.subviews) {
        if ([subView isKindOfClass:[UIButton class]])
            subView.hidden = YES;
    }
}

-(void) gameOverAlert:(int)currentColor {
    NSString *winnerMessage = @"Congratulations, you defeated the AI!";
    
    if (currentColor == 1) {
        winnerMessage = @"The AI defeated you, better luck next time!";
    } else if (currentColor == 2) {
        winnerMessage = @"It was a draw!";
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:winnerMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* playAgainAction = [UIAlertAction actionWithTitle:@"Rematch" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {[viewController gameReset];}];
    UIAlertAction* exitGameAction = [UIAlertAction actionWithTitle:@"Exit to Menu" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                                                [viewController gameReset];
                                                                [viewController presentMenu];}];
    UIAlertAction* viewBoardAction = [UIAlertAction actionWithTitle:@"View Board" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    
    [alert addAction:playAgainAction];
    [alert addAction:exitGameAction];
    [alert addAction:viewBoardAction];
    
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
