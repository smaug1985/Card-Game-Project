//
//  GameCenterScene.m
//  CardGame
//
//  Created by ender on 06/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameCenterScene.h"


@implementation GameCenterScene


+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Añado fondo de escena
	CCSprite *back = [[CCSprite alloc] initWithFile:@"table.png"];
	[back setAnchorPoint:CGPointMake(0, 0)];
	[scene addChild:back z:0 tag:0];
	
	// 'layer' is an autorelease object.
	GameCenterLayer *layer = [GameCenterLayer node];
	//[layer authenticateLocalPlayer];
	// add layer as a child to scene
	[scene addChild:layer z:1 tag:1];
	
	// return the scene
	return scene;
}


@end
