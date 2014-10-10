//
//  GameCenter.h
//  CardGame
//
//  Created by gali on 15/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>

@protocol GameCenterEvents<NSObject>

-(void) GotScore:(int64_t) i;

@end

@interface GameCenter : NSObject <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GKMatchmakerViewControllerDelegate> {

	id<GameCenterEvents> delegate;
	
}

@property (nonatomic,retain) id<GameCenterEvents> delegate;

@end
