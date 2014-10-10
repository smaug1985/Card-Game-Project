//
//  BJCardLayer.m
//  CardGame
//
//  Created by gali on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BJCardLayer.h"


@implementation BJCardLayer
@synthesize delegate,playerBJ,card;

- (void) drawCards:(PlayerBJ *)player card:(Card *)c
{
	self.playerBJ = player; 
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	c.image.scale = CARDSCALE;
	c.image.anchorPoint = ccp(0.5,0.5);
	c.image.position = ccp(s.width/2+100, s.height - (c.image.contentSize.height*c.image.scale)+10);
	//ccp(s.width/2+120+(c.image.contentSize.width*CARDSCALE)/2, s.height - ((c.image.contentSize.height*CARDSCALE+21*CARDSCALE)/2));
	//c.image.rotation = 20.0;
	
	int marginLeft = 25;
	int marginBottom = 5;
	float cuarto = s.width/4;
	CGPoint point;
	
	//Delay entre jugador y jugador
	float delay;
	//Entero para contar los jugadores que hay en mesa y asi calcular el delay para repartir al dealer
	//Le dare valores dentro del while segun el numero del jugador en el que entre
	int cntPlayers;
	
	switch (player.position) {
			
		case PositionInTableLeft:
			
			point = CGPointMake(marginLeft+(c.image.contentSize.width*c.image.scale)/2, marginBottom+(c.image.contentSize.height*c.image.scale)/2);
			delay = 0.2;
			break;
			
		case PositionInTableMiddleLeft:
			point = CGPointMake(cuarto+marginLeft+(c.image.contentSize.width*c.image.scale)/2, marginBottom+(c.image.contentSize.height*c.image.scale)/2);
			delay = 0.4;
			break;
			
		case PositionInTableMiddleRight:
			
			point = CGPointMake(cuarto*2+marginLeft+(c.image.contentSize.width*c.image.scale)/2, marginBottom+(c.image.contentSize.height*c.image.scale)/2);
			delay = 0.6;
			break;
			
		case PositionInTableRight:
			
			point = CGPointMake(cuarto*3+marginLeft+(c.image.contentSize.width*c.image.scale)/2, marginBottom+(c.image.contentSize.height*c.image.scale)/2);
			delay = 0.8;
			break;
		default:
			
			point = CGPointMake(s.width/2-20, s.height - 100);
			delay = 1;
			break;
	}
	
	//Delay para la segunda carta
	float delay2;
	//Margen para la segunda carta
	int marginExtra;
	
	if ([player.playerHand count] == 2) {
		
		marginExtra = 10;
		delay2 = 1;
		
	}else if ([player.playerHand count] > 2) {
		
		marginExtra = 10*([player.playerHand count]-1);
		delay = 0.2;
		delay2 = 0;
		
	}else{
		
		marginExtra = 0;
		delay2 = 0;
		
	}
	
	if (player.position == PositionInTableTop) {
		if ([player.playerHand count] == 2) {
			[c cambiarEstado];
		}
	}
	
	id action = [CCMoveTo actionWithDuration:0.3 position:ccp(point.x+marginExtra,point.y)];
	id action2 = [CCRotateBy actionWithDuration:0.3 angle:180];
	id action3 = [CCDelayTime actionWithDuration:delay+delay2];
	//id action4 = [CCScaleTo actionWithDuration:0.5 scale:0.5];
	//id action5 = [CCScaleTo actionWithDuration:0.5 scale:CARDSCALE];
	
	[self addChild:c.image];
	[c.image runAction:[CCSequence actions:action3,action,nil]];
	
	if (self.playerBJ.position == PositionInTableTop) {
		if ([self.playerBJ.playerHand count] == 2) {
		
			[c.image runAction:[CCSequence actions:action3,action2,
								[CCCallFunc actionWithTarget:self selector:@selector(animationMade)],
								nil]];
			
		}else {
			
			[c.image runAction:[CCSequence actions:action3,action2,
								nil]];
			
		}

	}else {
		
		[c.image runAction:[CCSequence actions:action3,action2,
							nil]];
		
	}

	
	
	

}

-(void) changeCardsFor:(PlayerBJ *)dealer withCallFunc:(BOOL) stateChanged{

	for (int i=0; i<[dealer.playerHand count]; i++) {
		Card *c = [dealer.playerHand objectAtIndex:i];
		if (!c.pos) {
			
			CCAction *scaleAction1 = [CCScaleTo actionWithDuration:0.25 scale:0.40];
			CCAction *scaleAction2 = [CCScaleTo actionWithDuration:0.25 scale:0.35];
			[c.image runAction:[CCSequence actions:scaleAction1,
								scaleAction2,
								nil]];
			
			id orbit1 = [CCOrbitCamera actionWithDuration:0.25/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
			id orbit2 = [CCOrbitCamera actionWithDuration:0.25/2 radius:1 deltaRadius:0 angleZ:90 deltaAngleZ:90 angleX:0 deltaAngleX:0];
			
			self.card = c;
			
			if (stateChanged) {
				[c.image runAction: [CCSequence actions:
									 orbit1,
									 [CCCallFunc actionWithTarget:self selector:@selector(changeCardState)],
									 orbit2,
									 [CCCallFunc actionWithTarget:self.delegate selector:@selector(stateChanged)],
									 nil]];
				
			}
			
			else {
				[c.image runAction: [CCSequence actions:
									 orbit1,
									 [CCCallFunc actionWithTarget:self selector:@selector(changeCardState)],
									 orbit2,
									 nil]];
			}

			
			
			
		
		}
	}

}

-(void) changeCardState{

	[self.card cambiarEstado];

}

-(void) animationMade {

	if([self.delegate respondsToSelector:@selector(animationCardMade)])
		[self.delegate animationCardMade];
	
}

- (void) changeStateAnimationFor:(Card *)card{

	

}

- (void) removeAllCardsFromTable{

	CGSize s = [[CCDirector sharedDirector] winSize];
	
	CCAction *action = [CCMoveTo actionWithDuration:0.2 position:ccp(-30, s.height+30)];
	int j=0;
	for (int i=[self.children count]-1; i>=0; i--) {
		
		Card *card = [self.children objectAtIndex:i];
		
		CCAction * action2 = [CCCallFunc actionWithTarget:card selector:@selector(removeFromParentAndCleanup:)];
		CCAction *delay = [CCDelayTime actionWithDuration:0.2*j];
		CCAction *delayFinal = [CCDelayTime actionWithDuration:1];
		
		if (card == [self.children objectAtIndex:0]) {
			
			[card runAction:[CCSequence actions:delay,
							 action,
							 delayFinal,
							 action2,
							 [CCCallFunc actionWithTarget:self selector:@selector(removeMade)],
							 nil]];
			
		}else {
			
			[card runAction:[CCSequence actions:delay,
							 action,
							 action2,
							 nil]];
			
		}

		j++;
		
	}

}

- (void) removeMade{
	if([self.delegate respondsToSelector:@selector(removeCardMade)])
		[self.delegate removeCardMade];

}

- (void) dealloc{
	
	[delegate release];
	[playerBJ release];
	[card release];
	
	[super dealloc];
	
}

@end
