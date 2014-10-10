//
//  waitLayer.m
//  CardGame
//
//  Created by gali on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "waitLayer.h"


@implementation waitLayer

@synthesize menuWait,layerBJ;

-(id) initWithMatch:(GKMatch *) aMatch isHost:(BOOL) host{
	
	if ((self = [super init])) {
		CCSprite *back = [[CCSprite alloc] initWithFile:@"black.png"];
		[back setAnchorPoint:CGPointMake(0, 0)];
		[self addChild:back z:0 tag:0];
		
		// 'layer' is an autorelease object.
		self.layerBJ = [[[BlackJackOnlineLayer alloc] initWithMatch:aMatch] autorelease];
		self.layerBJ.isHost = host;
		
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		
		CCLabel *label1 = [CCLabel labelWithString:NSLocalizedString(@"wait", @"wait") fontName:@"Royalacid_o" fontSize:30];
		CCMenuItem *menuItem1 = [CCMenuItemFont itemWithLabel:label1 block:nil];
		
		
		
		self.menuWait = [CCMenu menuWithItems:menuItem1,nil];
		self.menuWait.position = ccp(s.width/2, s.height/2);
		
		
		[self addChild:self.menuWait z:0];
		
	}
	return self;
	
	
	
}

-(void) dealloc{
	[self.menuWait release];
	[self.layerBJ release];
	[super dealloc];
}
@end
