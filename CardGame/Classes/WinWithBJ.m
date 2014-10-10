//
//  WinWithBJ.m
//  CardGame
//
//  Created by gali on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WinWithBJ.h"


@implementation WinWithBJ
@synthesize background,winBJ;

-(id) init{
	
	if( (self=[super init])) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//Añado el fondo
		self.background = [[CCSprite alloc] initWithFile:@"ModalMenu.png"];
		[self.background setAnchorPoint:ccp(1, 0.5)];
		//background.position = ccp(-background.contentSize.width,0);
		self.background.position = ccp(-self.background.contentSize.width,s.height/2);
		[self addChild:self.background z:1];
		
		
		self.winBJ = [CCLabel labelWithString:@"Black Jack!!!!" fontName:@"Royalacid_o" fontSize:35];
		self.winBJ.anchorPoint = ccp(0.5,0.5);
		self.winBJ.position = ccp(s.width/2 , s.height/2);
		self.winBJ.opacity = 0.0;
		[self addChild:self.winBJ z:3];
		
		
	}
	return self;
}

- (void) showWinBJ{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *backgroundAction = [CCMoveTo actionWithDuration:0.5 position:ccp(background.contentSize.width, s.height/2)];
	CCAction *fadeInAction1 = [CCFadeIn actionWithDuration:0.2];
	
	//Animo el fondo
	[self.background runAction:[CCSequence actions:backgroundAction,
								nil]];
	
	[self.winBJ runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.5],
						   fadeInAction1,
						   [CCCallFunc actionWithTarget:self selector:@selector(hideView)],
						   nil]];
	

	
}

-(void) hideWinBJ {
	
	CCAction *action1 = [CCMoveBy actionWithDuration:0.5 position:ccp(-background.contentSize.width, 0)];
	CCAction *fadeOutAction1 = [CCFadeOut actionWithDuration:0.2];
	
	//Animo el label de la apuesta
	[self.winBJ runAction:fadeOutAction1];
	
	
	//Animo el fondo
	[background runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.2],
						   action1,
						   nil]];
	
}

-(void) hideView {

	[self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5],[CCCallFunc actionWithTarget:self selector:@selector(hideWinBJ)],nil]];
	
}

@end
