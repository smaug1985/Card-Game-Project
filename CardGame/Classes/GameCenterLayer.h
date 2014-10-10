//
//  GameCenterLayer.h
//  CardGame
//
//  Created by ender on 06/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import "LoadMenuLayer.h"
@interface GameCenterLayer : CCLayer <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GKMatchmakerViewControllerDelegate, LoadMenuEvents> {

	
	
	BOOL matchStarted;
	NSMutableArray *arrayOfPlayers;
	CCMenu *footMenu;
	LoadMenuLayer * loadMenu;
	
	
}



@property(nonatomic, retain) NSMutableArray *arrayOfPlayers;
@property(nonatomic) BOOL matchStarted;
@property(nonatomic, retain) CCMenu *footMenu;
@property (nonatomic, retain) LoadMenuLayer * loadMenu;


-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled;
@end
