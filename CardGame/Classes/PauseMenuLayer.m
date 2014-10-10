//
//  PauseMenuLayer.m
//  CardGame
//
//  Created by Fran on 14/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PauseMenuLayer.h"


@implementation PauseMenuLayer
@synthesize menu,resumeButton,exitButton,background,delegate;


-(id) init{
	
	if( (self=[super init])) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//Añado el fondo
		background = [[CCSprite alloc] initWithFile:@"BJPause.png"];
		[background setAnchorPoint:ccp(0.5, 1)];
		//background.position = ccp(-background.contentSize.width,0);
		background.position = ccp(s.width/2,0);
		[self addChild:background z:1];
		
		
		
		
		CCLabel *exitLabel = [CCLabel labelWithString:NSLocalizedString(@"exit", @"exit") fontName:@"Royalacid_o" fontSize:25];
		exitButton = [CCMenuItemLabel itemWithLabel:exitLabel target:self selector:@selector(exitPlayer)];
		
		CCLabel *resumeLabel = [CCLabel labelWithString:NSLocalizedString(@"resume", @"resume") fontName:@"Royalacid_o" fontSize:25];
		resumeButton = [CCMenuItemLabel itemWithLabel:resumeLabel target:self selector:@selector(resumePlayer)];
		
		//Añado los elementos al menu y añado el menu
		self.menu = [CCMenu menuWithItems:resumeButton, exitButton, nil];
		//Configuro el menu
		[self.menu alignItemsVerticallyWithPadding:30];
		[self.menu setAnchorPoint:ccp(0.5,0.5)];
		self.menu.position = ccp(s.width/2,s.height/2);
		self.menu.opacity = 0.0;
		
		[self addChild:menu z:3];
		[self disableMenu:menu set:YES];
		
		
	}
	return self;
}

-(void) exitPlayer{
	
	[self.delegate exitPause];
}

-(void) resumePlayer{
	
	[self hidePauseMenu];
	[self.delegate resumePause];

}

-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled{
	
	NSArray *ar=[m children];
	for(CCMenuItem *item in ar)
		[item setIsEnabled:!disabled];
}


- (void) showPauseMenu{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, background.contentSize.height)];
	CCAction *action2 = [CCFadeIn actionWithDuration:0.2];
	
	//Animo el fondo
	[background runAction:action1];
	
	
	//Animo el menu
	[self.menu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7],
						 action2,
						 nil]];
	
	[self disableMenu:self.menu set:NO];
}


-(void) hidePauseMenu{
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(0, -background.contentSize.height)];
	CCAction *action2 = [CCFadeOut actionWithDuration:0.2];
	
	//Animo el menu
	[menu runAction: action2];
	[self disableMenu:menu set:YES];
	
	[background runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
						   action1,
						   //[CCCallFunc actionWithTarget:self selector:@selector(removeMenu)],
						   nil]];

}



@end
