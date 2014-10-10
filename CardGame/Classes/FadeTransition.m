//
//  FadeTR.m
//  CardGame
//
//  Created by gali on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FadeTransition.h"


@implementation FadeTransition


-(void) onEnter
{
	//[super onEnter];
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	float aspect = s.width / s.height;
	int x = 12 * aspect;
	int y = 12;
	
	id action  = [self actionWithSize:ccg(x,y)];
	
	outScene.anchorPoint = ccp(0,0);
	
	[outScene runAction: [CCSequence actions:
						  [CCCallFunc actionWithTarget:self selector:@selector(setLandscape)],
						  [CCRotateTo actionWithDuration:0.001 angle:-90],
						  [CCCallFunc actionWithTarget:self selector:@selector(setPosition)],
						  [self easeActionWithAction:action],
						  [CCCallFunc actionWithTarget:self selector:@selector(finish)],
						  [CCStopGrid action],
						  nil]
	 ];
}


-(void) setLandscape {
	// Sets landscape mode
	[[CCDirector sharedDirector] setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
}

-(void) setPosition {
	CGSize s = [[CCDirector sharedDirector] winSize];
	[outScene setPosition:ccp(s.width,0)];
}

@end

