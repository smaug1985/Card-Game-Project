//
//  CardGameAppDelegate.h
//  CardGame
//
//  Created by Fran on 28/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import "MainScene.h"
#import "BJScene.h"
#import "MainMenuLayer.h"
#import "GameListLayer.h"
#import "OptionMenuLayer.h"
#import "OptionDeckLayer.h"
#import "GameDescriptionLayer.h"
#import "GameSettings.h"
#import "cocos2d.h"
#import "GameCenterScene.h"


@interface CardGameAppDelegate : NSObject <UIApplicationDelegate, GKAchievementViewControllerDelegate, GKMatchmakerViewControllerDelegate> {
	
	UIWindow *window;
	NSNotificationCenter *notifyCenter;
	NSMutableDictionary *achievementsDictionary;


	
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) NSNotificationCenter *notifyCenter;
@property(nonatomic, retain) NSMutableDictionary *achievementsDictionary;

- (void) trackNotifications: (NSNotification *) notification;
- (void) showUIViewController:(UIViewController *) controller;
- (void) hideUIViewController:(UIViewController *) controller;
- (void) authenticateLocalPlayer;
- (void) loadAchievements;
- (void) showAchievements;

@end
