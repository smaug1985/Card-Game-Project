//
//  GameScene.m
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BJScene.h"


@implementation BJScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Añado fondo de escena
	CCSprite *back = [[CCSprite alloc] initWithFile:@"blackjackTable.png"];
	[back setAnchorPoint:CGPointMake(0, 0)];
	[scene addChild:back z:0 tag:0];
	
	// 'layer' is an autorelease object.
	BlackjackLayer *layer = [BlackjackLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer z:1 tag:1];
	
	// return the scene
	return scene;
}

+(id) sceneWithMatch:(GKMatch *) aMatch isHost:(BOOL) host{
	
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Añado fondo de escena
	CCSprite *back = [[CCSprite alloc] initWithFile:@"blackjackTable.png"];
	[back setAnchorPoint:CGPointMake(0, 0)];
	[scene addChild:back z:0 tag:0];
	
	waitLayer *layer = [[[waitLayer alloc] initWithMatch:aMatch isHost:host] autorelease];
	// add layer as a child to scene
	[scene addChild:layer z:1 tag:1];
	
	// return the scene
	return scene;
	
	
}

@end
