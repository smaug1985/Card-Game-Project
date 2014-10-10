//
//  MainMenuLayer.h
//  CardGame
//
//  Created by gali on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameCenter.h"

@interface MainMenuLayer : CCLayer <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate> {
	
	GameCenter *gc;
	
}

@property (nonatomic,retain) GameCenter *gc;

@end
