//
//  BlackjackDescriptionLayer.m
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameDescriptionLayer.h"
#import "BJDescription.h"

@implementation GameDescriptionLayer
@synthesize des;

// on "init" you need to initialize your instance
-(id) init
{

	if( (self=[super init])) {
		
		// ask director the the window size
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		// create and initialize a Label
		CCLabel* title = [CCLabel labelWithString:@"Blackjack" fontName:@"Royalacid_o" fontSize:50];
		
		title.position =  ccp( s.width /2 , s.height-title.contentSize.height );
		
		[self addChild:title];
		
		BJDescription *gameDescriptionLayer = [BJDescription node];
		gameDescriptionLayer.position = ccp(10, s.height-title.contentSize.height - gameDescriptionLayer.contentSize.height);
		[self addChild:gameDescriptionLayer];
		
		
		
		CCLabel *play = [CCLabel labelWithString:NSLocalizedString(@"play", @"play") fontName:@"Royalacid_o" fontSize:30];
		CCMenuItem *menuItemPlay = [CCMenuItemFont itemWithLabel:play target:self selector:@selector(playItem)];
		menuItemPlay.position = ccp(s.width-menuItemPlay.contentSize.width/2, menuItemPlay.contentSize.height/2);
		
		CCLabel *settings = [CCLabel labelWithString:NSLocalizedString(@"settings", @"settings") fontName:@"Royalacid_o" fontSize:30];
		CCMenuItem *menuItemSettigs = [CCMenuItemFont itemWithLabel:settings target:self selector:@selector(settingsItem)];
		menuItemSettigs.position = ccp(s.width/2, menuItemSettigs.contentSize.height/2);
		
		CCMenuItemLabel *backItem = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrowOver.png" target:self selector:@selector(backItem)];
		backItem.position = ccp(backItem.contentSize.width/2,backItem.contentSize.height/2);
		
		CCLabel *playOnline = [CCLabel labelWithString:NSLocalizedString(@"Play Online", @"play") fontName:@"Royalacid_o" fontSize:30];
		CCMenuItem *menuItemPlayOnline = [CCMenuItemFont itemWithLabel:playOnline target:self selector:@selector(playOnlineItem)];
		menuItemPlayOnline.position = ccp(s.width-menuItemPlayOnline.contentSize.width/2, menuItemPlayOnline.contentSize.height*2 );
		
		
		CCMenu *footMenu = [CCMenu menuWithItems:menuItemPlay, menuItemSettigs, backItem, menuItemPlayOnline,nil];
		footMenu.position = ccp(0,0);
		
		[self addChild:footMenu];
		
		bjConfLayer = [BJSettingsLayer node];
		[self addChild:bjConfLayer];
		
	}
	return self;
}

-(void) backItem{
	if (!bjConfLayer.isShowing) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"backGameListFromRight" object:@""];
	}
}

-(void) playItem{
	if (!bjConfLayer.isShowing) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"blackjack" object:@""];
	}
}

-(void) settingsItem{
	
	if (!bjConfLayer.isShowing) {
		[bjConfLayer showSettings];
	}
	
}

-(void) playOnlineItem{
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"OnlineMenu" object:@""];
	
}


@end
