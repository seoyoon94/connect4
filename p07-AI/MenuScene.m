//
//  MenuScene.m
//  p07-AI
//
//  Created by Seoyoon Park on 4/11/16.
//  Copyright © 2016 bkim35. All rights reserved.
//

#import "MenuScene.h"

@implementation MenuScene

@synthesize viewController;
@synthesize selfView;

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    screenWidth = view.bounds.size.width;
    screenHeight = view.bounds.size.height;
    selfView = self.view;
    
    self.backgroundColor = [UIColor grayColor];
    SKSpriteNode *title = [[SKSpriteNode alloc] initWithImageNamed:@"title.png"];
    title.size = CGSizeMake(selfView.frame.size.width, title.size.height);
    title.position = CGPointMake(title.size.width / 2, 2 * screenHeight / 3 + title.size.height);
    [self addChild:title];
    
    SKSpriteNode *easyButton = [SKSpriteNode spriteNodeWithImageNamed:@"easyButton.png"];
    easyButton.size = CGSizeMake(selfView.frame.size.width / 2 * 3/4, selfView.frame.size.height / 10 * 3/4);
    easyButton.position = CGPointMake(selfView.frame.size.width / 2, title.position.y - 2 * easyButton.size.height);
    easyButton.name = @"easyButton";
    [self addChild:easyButton];
    
    SKSpriteNode *mediumButton = [SKSpriteNode spriteNodeWithImageNamed:@"mediumButton.png"];
    mediumButton.position = CGPointMake(selfView.frame.size.width / 2, easyButton.position.y - 1.5 * easyButton.size.height);
    mediumButton.size = easyButton.size;
    mediumButton.name = @"mediumButton";
    [self addChild:mediumButton];
    
    SKSpriteNode *hardButton = [SKSpriteNode spriteNodeWithImageNamed:@"hardButton.png"];
    hardButton.position = CGPointMake(selfView.frame.size.width / 2, mediumButton.position.y -  1.5 * easyButton.size.height);
    hardButton.size = easyButton.size;
    hardButton.name = @"hardButton";
    [self addChild:hardButton];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *buttonAtLocation = [self nodeAtPoint:location];
        
        if ([buttonAtLocation.name isEqualToString:@"easyButton"]) {
            SKAction *colorChage = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:.5 duration:.001];
            [buttonAtLocation runAction:colorChage];
            [viewController startGame:2];
        } else if ([buttonAtLocation.name isEqualToString:@"mediumButton"]) {
            SKAction *colorChage = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:.5 duration:.001];
            [buttonAtLocation runAction:colorChage];
            [viewController startGame:4];
        } else if ([buttonAtLocation.name isEqualToString:@"hardButton"]) {
            SKAction *colorChage = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:.5 duration:.001];
            [buttonAtLocation runAction:colorChage];
            [viewController startGame:7];
        }
    }
}

@end