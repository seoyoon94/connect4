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
    
    SKScene *menuScreen = [self initMenuScreen];
    [self.view presentScene:menuScreen];
//    [self.view presentScene:[self initGameBoard]];
}

-(SKScene *) initMenuScreen{
    SKScene *scene = [[SKScene alloc] initWithSize:selfView.frame.size];
    scene.backgroundColor = [UIColor blackColor];
    SKSpriteNode *title = [[SKSpriteNode alloc] initWithImageNamed:@"title.png"];
    title.size = CGSizeMake(selfView.frame.size.width, title.size.height);
    title.position = CGPointMake(title.size.width / 2, 2 * screenHeight / 3 + title.size.height);
    [scene addChild:title];
    
    SKSpriteNode *easyButton = [SKSpriteNode spriteNodeWithImageNamed:@"easyButton.png"];
    easyButton.size = CGSizeMake(selfView.frame.size.width / 2 * 3/4, selfView.frame.size.height / 10 * 3/4);
    easyButton.position = CGPointMake(selfView.frame.size.width / 2, title.position.y - 2 * easyButton.size.height);
    easyButton.name = @"easyButton";
    [scene addChild:easyButton];
    
    SKSpriteNode *mediumButton = [SKSpriteNode spriteNodeWithImageNamed:@"mediumButton.png"];
    mediumButton.position = CGPointMake(selfView.frame.size.width / 2, easyButton.position.y - 1.5 * easyButton.size.height);
    mediumButton.size = easyButton.size;
    mediumButton.name = @"mediumButton";
    [scene addChild:mediumButton];
    
    SKSpriteNode *hardButton = [SKSpriteNode spriteNodeWithImageNamed:@"hardButton.png"];
    hardButton.position = CGPointMake(selfView.frame.size.width / 2, mediumButton.position.y -  1.5 * easyButton.size.height);
    hardButton.size = easyButton.size;
    hardButton.name = @"hardButton";
    [scene addChild:hardButton];
    
//    UIButton *easyButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
//    [easyButton setTitle:@"Easy" forState:UIControlStateNormal];
//    [scene.view addSubview:easyButton];
//    
//    UIButton *mediumButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
//    [mediumButton setTitle:@"Medium" forState:UIControlStateNormal];
//    [scene.view addSubview:mediumButton];
//    
//    UIButton *hardButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
//    [hardButton setTitle:@"Hard" forState:UIControlStateNormal];
//    [scene.view addSubview:hardButton];
    
    return scene;
}

-(SKScene *) initGameBoard{
    SKScene *scene = [[SKScene alloc] initWithSize:selfView.frame.size];
    numColumns = 7;
    numRows = 6;
    scene.backgroundColor = [SKColor blackColor];
    
    
    int tempTag = 0;
    for(int i = 0; i < numColumns; i++){
        //Create game board
        SKSpriteNode *column = [[SKSpriteNode alloc] initWithImageNamed:@"connect4.png"];
        column.size = CGSizeMake(screenWidth / 9, (screenWidth/9) * 6.15);
        columnWidth = column.size.width;
        columnHeight = column.size.height;
        column.position = CGPointMake(screenWidth / 9 + i * columnWidth + columnWidth/2, screenHeight/2);
        [scene addChild:column];
        
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
        [scene.view addSubview:columnButton];
    }
    
    return scene;
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
}

-(void) gameOverAlert:(int)currentColor {
    NSString *winnerMessage = @"Congratulations, you defeated the AI!";
    
    if (currentColor == 1) {
        winnerMessage = @"The AI defeated you, better luck next time!";
    }
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Game Over"
                                                                   message:winnerMessage
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* playAgainAction = [UIAlertAction actionWithTitle:@"Rematch" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {[viewController gameReset];}];
    UIAlertAction* exitGameAction = [UIAlertAction actionWithTitle:@"Exit to Menu" style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {NSLog(@"exit game");}];
    
    [alert addAction:playAgainAction];
    [alert addAction:exitGameAction];
    UIViewController *vc = self.view.window.rootViewController;
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
