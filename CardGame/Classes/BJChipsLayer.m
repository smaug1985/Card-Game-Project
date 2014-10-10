//
//  BJPlayerLayer.m
//  CardGame
//
//  Created by gali on 06/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BJChipsLayer.h"

@implementation BJChipsLayer

-(id) initWith:(PlayerBJ *) player
{
	
	if( (self=[super init])) {
		
		[self drawChips:player];
		
	}
	return self;
}

- (void) drawChips:(PlayerBJ *)player{

	if ([[self children] count] > 0) {
		[self removeAllChildrenWithCleanup:YES];
	}
	
	//self.frame = [CGRectMake(0, 0, 125, 300)];
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	int marginLeft = 20;
	int marginBottom = 10;
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
		default:
			break;
	}
	
	for (int i=0; i<player.chips10; i++) {
		
		Chip *chip10 = [[Chip alloc] initWithFile:@"ficha10.png" value:10];
		chip10.scale = CHIPSCALE;
		chip10.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*0, point.y+i);
		[self addChild:chip10];
		[chip10 release];
	}
	for (int i=0; i<player.chips25; i++) {
		Chip *chip25 = [[Chip alloc] initWithFile:@"ficha25.png" value:25];
		chip25.scale = CHIPSCALE;
		chip25.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*1, point.y+i);
		[self addChild:chip25];
		[chip25 release];
	}
	for (int i=0; i<player.chips100; i++) {
		Chip *chip100 = [[Chip alloc] initWithFile:@"ficha100.png" value:100];
		chip100.scale = CHIPSCALE;
		chip100.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*2, point.y+i);
		[self addChild:chip100];
		[chip100 release];
	}
	for (int i=0; i<player.chips200; i++) {
		Chip *chip200 = [[Chip alloc] initWithFile:@"ficha200.png" value:200];
		chip200.scale = CHIPSCALE;
		chip200.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*3, point.y+i);
		[self addChild:chip200];
		[chip200 release];
	}
	for (int i=0; i<player.chips500; i++) {
		Chip *chip500 = [[Chip alloc] initWithFile:@"ficha500.png" value:500];
		chip500.scale = CHIPSCALE;
		chip500.position = ccp(point.x + CHIPWIDTH*CHIPSCALE*4, point.y+i);
		[self addChild:chip500];
		[chip500 release];
	}
	
}

- (void) dealloc{
	
	[super dealloc];

}

@end
