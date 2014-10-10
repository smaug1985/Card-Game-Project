//
//  CardDownLayer.m
//  CardGame
//
//  Created by gali on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CardDownLayer.h"


@implementation CardDownLayer

@synthesize deck;

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	//	ccc4(<#const GLubyte r#>, <#const GLubyte g#>, <#const GLubyte b#>, <#const GLubyte o#>)
	if( (self=[super init])) {
		
		deck = [[Deck alloc] initWithPlist:@"frenchDeck"];
		
		CCSequence *seq = [CCSequence actions: [CCDelayTime actionWithDuration:0.2],
						   [CCCallFunc actionWithTarget:self selector:@selector(cardDown)],
						   nil];
		
		[self runAction:[CCRepeatForever actionWithAction: seq]];
		
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
	
	[deck release];
	
	[super dealloc];
}

- (void) cardDown{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	//[node setContentSize:CGSizeMake(s.width,s.height)];
	//[node setAnchorPoint:ccp(0.5f, 0.5f)];
	//[node setPosition:ccp(s.width/2, s.height/2)];
	
	//Declaro algunas variables
	int rand;
	int initialPosX;
	int endPosX;
	float cardScale;
	
	Card *card;
	
	//Asigno valor aleatorio a la posicion inicial de X
	rand = arc4random() % (int)s.width;
	initialPosX = rand;
	
	//Asigno valor aleatorio a la posicion final de X
	rand = arc4random() % (int)s.width;
	endPosX = rand;
	
	//Asigno valor aleatorio al tamaño de la carta
	rand = arc4random() % 5;
	cardScale = (float)rand/10;
	
	card = [[deck pop] retain];
	
	if (card == nil) {
		
		[deck release];
		deck = [[Deck alloc] initWithPlist:@"frenchDeck"];
		card = [[deck pop] retain];
		
	}
	
	card.image.position = ccp(initialPosX,s.height+(card.image.textureRect.size.height/2));
	[card.image setScale:cardScale];
	
	if (cardScale > 0.3) {
		[card cambiarEstado];
	}
	
	[self addChild:card.image z:rand];
	
	id action1;
	id action2;
	//id action3;
	
	action1 = [CCMoveTo actionWithDuration:2 position:ccp(endPosX, -(card.image.textureRect.size.height/2))];
	action2 = [CCRotateBy actionWithDuration:4 angle:1800];
	//action3 = [CCFadeOut actionWithDuration:5];
	
	[card.image runAction:action1];
	//[card.image runAction:action2];
	
	
	float d = 1.5f;
	id orbit1 = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	id orbit2 = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	[card.image runAction: [CCSequence actions:
							orbit1,
							[CCCallFunc actionWithTarget:card selector:@selector(cambiarEstado)],
							orbit2,
							nil]];
	
	//NSLog(@"count: %d",[[self children]count]);
	
	[card.image runAction:[CCSequence actions: action2,
						   [CCCallFunc actionWithTarget:card selector:@selector(liberar)],
						   nil]];
	
}

@end
