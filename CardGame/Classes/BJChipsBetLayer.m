//
//  BJChipsBetLayer.m
//  CardGame
//
//  Created by gali on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BJChipsBetLayer.h"


@implementation BJChipsBetLayer

-(id) initWith:(PlayerBJ *) player
{
	
	if( (self=[super init])) {
		
		[self drawChipsBet:player];
		
	}
	return self;
}

- (void) drawChipsBet:(PlayerBJ *)player{
	
	if ([[self children] count] > 0) {
		[self removeAllChildrenWithCleanup:YES];
	}
	
	//self.frame = [CGRectMake(0, 0, 125, 300)];
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	int marginLeft = 20;
	int marginBottom = 10;
	int marginBottom2 = 130;
	float cuarto = s.width/4;
	CGPoint point;
	
	switch (player.position) {
			
		case PositionInTableLeft:
			
			point = CGPointMake(marginLeft, marginBottom);
			
			break;
			
		case PositionInTableMiddleLeft:
			
			point = CGPointMake(cuarto+marginLeft, marginBottom);
			
			break;
			
		case PositionInTableMiddleRight:
			
			point = CGPointMake(cuarto*2+marginLeft, marginBottom);
			
			break;
			
		case PositionInTableRight:
			
			point = CGPointMake(cuarto*3+marginLeft, marginBottom);
			
			break;
		
		case PositionInTableTop:
			
			point = CGPointMake(s.width/2, 20);
			
			break;
		
		default:
			break;
	}
	
	for (int i=0; i<player.chipsBet10; i++) {
		Chip *chip10 = [[Chip alloc] initWithFile:@"ficha10.png" value:10];
		chip10.scale = CHIPSCALE;
		chip10.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*0, point.y+i);
		
		id delay = [CCDelayTime actionWithDuration:i*0.2];
		id action = [CCMoveTo actionWithDuration:0.2 position:ccp(point.x + CHIPWIDTH*CHIPSCALE*0, marginBottom2+i)];
		[self addChild:chip10];
		[chip10 runAction:[CCSequence actions:delay,action,nil]];
		[chip10 release];
	}
	for (int i=0; i<player.chipsBet25; i++) {
		Chip *chip25 = [[Chip alloc] initWithFile:@"ficha25.png" value:25];
		chip25.scale = CHIPSCALE;
		chip25.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*1, point.y+i);
		
		id delay = [CCDelayTime actionWithDuration:i*0.3];
		id action = [CCMoveTo actionWithDuration:0.3 position:ccp(point.x + CHIPWIDTH*CHIPSCALE*1, marginBottom2+i)];
		[self addChild:chip25];
		[chip25 runAction:[CCSequence actions:delay,action,nil]];
		[chip25 release];
	}
	for (int i=0; i<player.chipsBet100; i++) {
		Chip *chip100 = [[Chip alloc] initWithFile:@"ficha100.png" value:100];
		chip100.scale = CHIPSCALE;
		chip100.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*2, point.y+i);
		
		id delay = [CCDelayTime actionWithDuration:i*0.4];
		id action = [CCMoveTo actionWithDuration:0.4 position:ccp(point.x + CHIPWIDTH*CHIPSCALE*2, marginBottom2+i)];
		[self addChild:chip100];
		[chip100 runAction:[CCSequence actions:delay,action,nil]];
		[chip100 release];
	}
	for (int i=0; i<player.chipsBet200; i++) {
		Chip *chip200 = [[Chip alloc] initWithFile:@"ficha200.png" value:200];
		chip200.scale = CHIPSCALE;
		chip200.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*3, point.y+i);
		
		id delay = [CCDelayTime actionWithDuration:i*0.5];
		id action = [CCMoveTo actionWithDuration:0.5 position:ccp(point.x + CHIPWIDTH*CHIPSCALE*3, marginBottom2+i)];
		[self addChild:chip200];
		[chip200 runAction:[CCSequence actions:delay,action,nil]];
		[chip200 release];
	}
	for (int i=0; i<player.chipsBet500; i++) {
		Chip *chip500 = [[Chip alloc] initWithFile:@"ficha500.png" value:500];
		chip500.scale = CHIPSCALE;
		chip500.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*4, point.y+i);
		
		id delay = [CCDelayTime actionWithDuration:i*0.6];
		id action = [CCMoveTo actionWithDuration:0.6 position:ccp(point.x + CHIPWIDTH*CHIPSCALE*4, marginBottom2+i)];
		[self addChild:chip500];
		[chip500 runAction:[CCSequence actions:delay,action,nil]];
		[chip500 release];
	}
	
}

- (void) animationFromPlayerBetToDealer:(PlayerBJ *)player{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CGPoint point = CGPointMake(s.width/2, s.height+30);
	
	CCAction *action = [CCMoveTo actionWithDuration:0.1 position:ccp(point.x, point.y)];
	int j=0;
	for (int i=[self.children count]-1; i>=0; i--) {
		
		Chip *chip = [self.children objectAtIndex:i];
		
		CCAction * action2 = [CCCallFunc actionWithTarget:chip selector:@selector(removeFromParentAndCleanup:)];
		CCAction *delay = [CCDelayTime actionWithDuration:0.1*j];
		
		[chip runAction:[CCSequence actions:delay,
						 action,
						 action2,
						 nil]];
		j++;
	}

}


- (void) animationFromDealerToPlayerBet:(PlayerBJ *)player{
	
	
	
}


- (void) animationFromPlayerBetToPlayer:(PlayerBJ *)player{

	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action = [CCMoveBy actionWithDuration:0.1 position:ccp(0, -130)];
	int j=0;
	for (int i=[self.children count]-1; i>=0; i--) {
		
		Chip *chip = [self.children objectAtIndex:i];
		
		CCAction * action2 = [CCCallFunc actionWithTarget:chip selector:@selector(removeFromParentAndCleanup:)];
		CCAction *delay = [CCDelayTime actionWithDuration:0.1*j];
		
		[chip runAction:[CCSequence actions:delay,
						 action,
						 action2,
						 nil]];
		j++;
	}

}

- (void) drawChips:(PlayerBJ *)player withResult:(PlayerResult)result{

	if (result == PlayerLose) {
		
		[self animationFromPlayerBetToDealer:player];
		
	}else if (result == PlayerWin) {
		
		[self animationFromPlayerBetToPlayer:player];
		//Tambien desde dealer a player
		
	}else {
		
		[self animationFromPlayerBetToPlayer:player];
		
	}



}

- (void) dealloc{
	
	[super dealloc];
	
}

@end
