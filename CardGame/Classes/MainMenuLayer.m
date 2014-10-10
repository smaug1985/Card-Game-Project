//
//  MainMenuLayer.m
//  CardGame
//
//  Created by gali on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MainMenuLayer.h"


@implementation MainMenuLayer

@synthesize gc;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	//	ccc4(<#const GLubyte r#>, <#const GLubyte g#>, <#const GLubyte b#>, <#const GLubyte o#>)
	if( (self=[super init])) {
		
		gc = [[GameCenter alloc] init];
		
		// ask director the the window size
		//CGSize s = [[CCDirector sharedDirector] winSize];
		
		// Añado cuadro blanco
		CCSprite *cuadro = [[CCSprite alloc] initWithFile:@"cuadroMenu.png"];
		[cuadro setAnchorPoint:CGPointMake(0, 0)];
		[self addChild:cuadro];
		
		// create and initialize a Label
		//CCLabel* label = [CCLabel labelWithString:@"Casino" fontName:@"Marker Felt" fontSize:80];
		
		// position the label on the center of the screen
		//label.position =  ccp( size.width /2 , size.height-label.textureRect.size.height );
		
		// add the label as a child to this Layer
		//[self addChild:label z:2];

		
		//Menú principal
		//Label Titulo
		//CCLabel *title = [CCLabel labelWithString:@"Main Menu" fontName:@"Royalacid" fontSize:50];
		//title.position = ccp(160, 450);
		//[self addChild: title];
		
		//Opciones de menú
		//CCBitmapFontAtlas *label1 = [CCBitmapFontAtlas bitmapFontAtlasWithString:NSLocalizedString(@"play", @"play") fntFile:@"Royalacid_o.ttf"];
		CCLabel *playLbl = [CCLabel labelWithString:NSLocalizedString(@"play", @"play") fontName:@"Royalacid_o" fontSize:35];
		//playLbl.color = ccc3(200,200,255);
		CCLabel *leaderBoard = [CCLabel labelWithString:NSLocalizedString(@"leaderboard", @"leaderboard")
											   fontName:@"Royalacid_o" 
											   fontSize:35];
		CCLabel *achievements = [CCLabel labelWithString:NSLocalizedString(@"achievements", @"achievements")
												fontName:@"Royalacid_o" 
												fontSize:35];
		CCLabel *settingsLbl = [CCLabel labelWithString:NSLocalizedString(@"settings", @"settings") fontName:@"Royalacid_o" fontSize:35];
		CCLabel *helpLbl = [CCLabel labelWithString:NSLocalizedString(@"help", @"help") fontName:@"Royalacid_o" fontSize:35];

		
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithLabel:playLbl target:self selector:@selector(onPlay:)];
		//CCMenuItem *menuItem1 = [CCMenuItemFont itemFromString:NSLocalizedString(@"play", @"play") target:self selector:@selector(onPlay:)];
		CCMenuItem *menuItem2 = [CCMenuItemFont itemWithLabel:leaderBoard 
																 target:self.gc 
															   selector:@selector(showLeaderboard)];
	//	CCMenuItem *menuItem3 = [CCMenuItemFont itemWithLabel:achievements target:self.gc selector:@selector(showAchievements)];
		CCMenuItem *menuItem4 = [CCMenuItemFont itemWithLabel:settingsLbl target:self selector:@selector(onSettings:)];
	//	CCMenuItem *menuItem5 = [CCMenuItemFont itemWithLabel:helpLbl target:self selector:@selector(onHelp:)];
		
		//Añado Menú
		CCMenu *mainMenu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem4, nil];
		[mainMenu alignItemsVerticallyWithPadding:30];
		
		//mainMenu.position = CGPointZero;
		//menuItem1.position = ccp(menuItem1.contentSize.width/2+55,s.height-(menuItem1.contentSize.height/2)-55);
		
		[self addChild:mainMenu];
		
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[gc release];
	[super dealloc];
}

//Acciones de menú

- (void) onPlay:(id) sender {
	
	NSLog(@"on Play");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"play" object:@""];
}

- (void) onScores:(id) sender {
	NSLog(@"on Scores");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"scores" object:@""];
}

- (void) onSettings:(id) sender {
	
	NSLog(@"on Settings");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"settings" object:@""];
}

- (void) onHelp:(id) sender{
	
	NSLog(@"on Help");
	[[NSNotificationCenter defaultCenter] postNotificationName:@"help" object:@""];
}

@end
