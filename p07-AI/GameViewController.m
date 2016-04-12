//
//  GameViewController.m
//  p07-AI
//
//  Created by Brian Kim on 3/22/16.
//  Copyright (c) 2016 bkim35. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"
#import "MenuScene.h"
#import "Connect4.h"


@implementation SKScene (Unarchive)

+ (instancetype)unarchiveFromFile:(NSString *)file {
    /* Retrieve scene file path from the application bundle */
    NSString *nodePath = [[NSBundle mainBundle] pathForResource:file ofType:@"sks"];
    /* Unarchive the file to an SKScene object */
    NSData *data = [NSData dataWithContentsOfFile:nodePath
                                          options:NSDataReadingMappedIfSafe
                                            error:nil];
    NSKeyedUnarchiver *arch = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    [arch setClass:self forClassName:@"SKScene"];
    SKScene *scene = [arch decodeObjectForKey:NSKeyedArchiveRootObjectKey];
    [arch finishDecoding];
    
    return scene;
}

@end

@implementation GameViewController 

@synthesize moveInProgress;
@synthesize gameEnded;

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    if (!skView.scene) {
        skView.showsFPS = YES;
        skView.showsNodeCount = YES;
        
        // Create and configure the scene.
        //scene = [GameScene unarchiveFromFile:@"GameScene"];
        menuScene = [MenuScene sceneWithSize:skView.bounds.size];
        menuScene.scaleMode = SKSceneScaleModeAspectFill;
        menuScene.viewController = self;
        
        // Present the scene.
        [skView presentScene:menuScene];
        
        // Initialize Connect4 engine
        connect4 = [[Connect4 alloc] init];
        [connect4 initConnect4Board];
        connect4.delegate = self;
        moveInProgress = NO;
        gameEnded = NO;
    }
}

-(void) presentMenu{
    SKView * skView = (SKView *)self.view;
    [skView presentScene:menuScene];
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)buttonPressed:(UIButton *)sender {
    if (!moveInProgress) {
        moveInProgress = YES;
        if([connect4.numPiecesInColumn[sender.tag] intValue] < connect4.numRows) {
            [gameScene insertPieceInView:(int)sender.tag row:[connect4.numPiecesInColumn[sender.tag] intValue] player:0];
            [connect4 addPieceToBoard:(int)sender.tag];
            
            if (!gameEnded) {
                [self performSelector:@selector(callAI) withObject:nil afterDelay:0.5];
            }
        }
    }
    
    moveInProgress = NO;
}

-(void) callAI {
        int column = [connect4 findBestMove];
        int row = [connect4.numPiecesInColumn[column] intValue];
        [gameScene insertPieceInView:column row:row player:1];
        [connect4 addPieceToBoard:column];
}

- (void)gameDidEnd:(Connect4 *)connect4{
    [gameScene gameOverAlert:connect4.currentColor];
}

-(void)gameReset {
    gameEnded = NO;
    moveInProgress = NO;
    [connect4 clearBoard];
    [gameScene clearBoard];
}

-(void)startGame:(int)difficulty {
    NSLog(@"asdf: %d", difficulty);
    connect4.difficulty = difficulty;
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    gameScene = [GameScene sceneWithSize:skView.bounds.size];
    gameScene.scaleMode = SKSceneScaleModeAspectFill;
    gameScene.viewController = self;
    [skView presentScene:gameScene];
}

@end
