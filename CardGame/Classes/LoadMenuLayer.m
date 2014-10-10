//
//  LoadMenuLayer.m
//  CardGame
//
//  Created by gali on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LoadMenuLayer.h"


@implementation LoadMenuLayer


@synthesize menu,cancelButton,background,delegate,loadLabel, request;


-(id) init{
	
	if( (self=[super init])) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//Añado el fondo
		background = [[CCSprite alloc] initWithFile:@"BJConfig.png"];
		[background setAnchorPoint:ccp(0.5, 1)];
		//background.position = ccp(-background.contentSize.width,0);
		background.position = ccp(s.width/2,0);
		[self addChild:background z:1];
		
		self.loadLabel = [CCLabel labelWithString:@"... Loading ..." fontName:@"Royalacid_o" fontSize:25];
		self.loadLabel.anchorPoint = ccp(0.5,0.5);
		self.loadLabel.position = ccp(s.width/2 , s.height/2);
		self.loadLabel.opacity = 0.0;
		[self addChild:self.loadLabel z:3];
		
		
		CCLabel *cancelLabel = [CCLabel labelWithString:NSLocalizedString(@"cancel", @"cancel") fontName:@"Royalacid_o" fontSize:20];
		cancelButton = [CCMenuItemLabel itemWithLabel:cancelLabel target:self selector:@selector(cancelMenu)];
		
		//Añado los elementos al menu y añado el menu
		self.menu = [CCMenu menuWithItems:cancelButton, nil];
		//Configuro el menu
		[self.menu alignItemsVerticallyWithPadding:30];
		[self.menu setAnchorPoint:ccp(0.5,0.5)];
		self.menu.position = ccp(s.width/2,s.height/2-100);
		self.menu.opacity = 0.0;
		
		[self addChild:menu z:3];
		[self disableMenu:menu set:YES];
		
		
	}
	return self;
}

-(void) cancelMenu{
	
	[self hideLoadMenu];
	[self.delegate cancelLoad];
	
}

-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled{
	
	NSArray *ar=[m children];
	for(CCMenuItem *item in ar)
		[item setIsEnabled:!disabled];
}


- (void) showLoadMenuWithRequest: (GKMatchRequest *) aRequest{
	request = aRequest;
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, background.contentSize.height)];
	CCAction *action2 = [CCFadeIn actionWithDuration:0.2];
	CCAction *action3 = [CCFadeIn actionWithDuration:0.2];
	
	//Animo el fondo
	[self.background runAction:action1];
	
	
	//Animo el menu
	[self.menu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7],
						  action2,
						  nil]];
	
	//Animo el label
	[self.loadLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7],
						  action3,
						  nil]];
	
	[self disableMenu:self.menu set:NO];
}


-(void) hideLoadMenu{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -background.contentSize.height)];
	CCAction *action2 = [CCFadeOut actionWithDuration:0.2];
	CCAction *action3 = [CCFadeOut actionWithDuration:0.2];
	
	//Animo el menu
	[self.menu runAction: action2];
	[self disableMenu:menu set:YES];
	
	//Animo el label
	[self.loadLabel runAction: action3];
	
	
	[self.background runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
						   action1,
						   //[CCCallFunc actionWithTarget:self selector:@selector(removeMenu)],
						   nil]];
	
}


@end
