//
//  GameCenter.m
//  CardGame
//
//  Created by gali on 15/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameCenter.h"


@implementation GameCenter
@synthesize delegate;
#pragma mark -
#pragma mark GameCenter scores and leaderboards methods
- (void) reportScore: (int64_t) score forCategory: (NSString*) category

{
	
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
	
    scoreReporter.value = score;
	
	
	
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
		
		if (error != nil)
			
		{
			NSLog(@"Score reporting failed with error:%@", [error localizedDescription]);
            // handle the reporting error
			
        }
		
    }];
	
}

- (void) showLeaderboard

{
	
    GKLeaderboardViewController *leaderboardController = [[GKLeaderboardViewController alloc] init];
	
    if (leaderboardController != nil)
		
    {
		
        leaderboardController.leaderboardDelegate = self;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"showUIView" object:leaderboardController];
		// [self presentModalViewController: leaderboardController animated: YES];
		
    }
	
}

- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController

{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
	// [self dismissModalViewControllerAnimated:YES];
	
}

- (void) retrieveTopTenScores

{
	
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
	
    if (leaderboardRequest != nil)
		
    {
		
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
		
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
		
        leaderboardRequest.range = NSMakeRange(1,10);
		
        [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
			
            if (error != nil)
				;
			// handle the error.
			
			if (scores != nil)
				;
			// process the score information.
			
		}];
		
    }
	
}

int64_t v = 0;
- (void) retrieveLocalPlayerScore{
	
    GKLeaderboard *leaderboardRequest = [[GKLeaderboard alloc] init];
	
    if (leaderboardRequest != nil)
		
    {
		
        leaderboardRequest.playerScope = GKLeaderboardPlayerScopeGlobal;
		
        leaderboardRequest.timeScope = GKLeaderboardTimeScopeAllTime;
		leaderboardRequest.category=@"TMB2";
        [leaderboardRequest loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
			
            if (error != nil){
				NSLog(@"%@",error);
				// handle the error.
			}
			if (scores != nil){
				NSLog(@"got player puntuation:: %d", leaderboardRequest.localPlayerScore.value);
				v = leaderboardRequest.localPlayerScore.value;
				[self.delegate GotScore:v];
			}
			
			// process the score information.
			
		}];
		
    }
	
}

- (void) retrieveFriends

{
	
    GKLocalPlayer *lp = [GKLocalPlayer localPlayer];
	
    if (lp.authenticated)
		
    {
		
        [lp loadFriendsWithCompletionHandler:^(NSArray *friends, NSError *error) {
			
			if (error == nil){
				
				// use the player identifiers to create player objects.
				for (NSString* p in friends) {
					
					//NSString *str = player.playerID;
					//NSLog(@"Found friend: %@", [lp.friends objectAtIndex:0]);
					
				}
				
				
				
			}
			else{
				
				// report an error to the user.
				NSLog(@"Error ocurred retrieving friends: %@", [error localizedDescription]);
			}
			
			
			
		}];
	}
	
}

- (void) receiveMatchBestScores: (GKMatch*) match

{
	
    GKLeaderboard *query = [[GKLeaderboard alloc] initWithPlayerIDs: match.playerIDs];
	
    if (query != nil)
		
    {
		
        [query loadScoresWithCompletionHandler: ^(NSArray *scores, NSError *error) {
			
            if (error != nil)
				;
			// handle the error.
			
			if (scores != nil)
				;
			// process the score information.
			
		}];
		
    }
	
}


- (void) loadCategoryTitles

{
	
    [GKLeaderboard loadCategoriesWithCompletionHandler:^(NSArray *categories, NSArray *titles, NSError *error) {
		
        if (error != nil)
			
        {
			
            // handle the error
			
        }
		
        // use the category and title information
		
	}];
	
}




#pragma mark -
#pragma mark GameCenter matchmaking methods
- (IBAction)hostMatch: (id) sender

{
	
    GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
	
    request.minPlayers = 2;
	
	
    request.maxPlayers = 4;
	
	
	
    GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
	
    mmvc.matchmakerDelegate = self;
	
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"showUIView" object:mmvc];
	// [self presentModalViewController:mmvc animated:YES];
	
}
- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController

{
	
	
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
	
    // implement any specific code in your application here.
	
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error

{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
    //[self dismissModalViewControllerAnimated:YES];
	
    // Display the error to the user.
	
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match

{
	[viewController dismissModalViewControllerAnimated:YES];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
	//  [self dismissModalViewControllerAnimated:YES];
	//GameScene *scene = [GameScene node];
	//BlackjackLayer *layer = (BlackjackLayer*) [scene getChildByTag:1];
	//layer.myMatch = match;
    // Use a retaining property to retain the match.
	//asignarle el match a la clase blackjack
	
	
	
	//layer.myMatch.delegate = self;
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"blackJackPlayOnline" object:match];
	//[self sendTest:[self participantID]];
	
	
    // Start the game using the match.
	
}

- (IBAction)findProgrammaticMatch: (id) sender

{
	NSLog(@"looking for match...");
    GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
	
    request.minPlayers = 2;
	
    request.maxPlayers = 4;
	
	
	
    [[GKMatchmaker sharedMatchmaker] findMatchForRequest:request withCompletionHandler:^(GKMatch *match, NSError *error) {
		
        if (error)
			
        {
			NSLog(@"Error finding match: %@", [error localizedDescription]);
            // Process the error.
			
        }
		
        else if (match != nil)
			
        {
			NSLog(@"match found, joining...");
			// self.myMatch = match;// Use a retaining property to retain the match.
			[[NSNotificationCenter defaultCenter] postNotificationName:@"blackJackPlayOnline" object:match];
			
			
			
            // Start the match.
			
			
			
			//NSLog(@"number of players:: %d", [[match playerIDs] count]);
			//self.matchStarted = YES;
			//[self sendTest:@"holaaaaaaa"];
			
			
			
			
			
			
			
			
        }	
		
    }];
	
}


#pragma mark -

- (void) reportAchievementIdentifier: (NSString*) identifier percentComplete: (float) percent

{
	
    GKAchievement *achievement = [[[GKAchievement alloc] initWithIdentifier: identifier] autorelease];
	
    if (achievement)
		
    {
		
		achievement.percentComplete = percent;
		
		[achievement reportAchievementWithCompletionHandler:^(NSError *error)
		 
		 {
			 
			 if (error != nil)
				 ;
			 //guardarlo en local con nscoding protocol!
			 // Retain the achievement object and try again later (not shown).
			 
		 }];
		
    }
	
}



- (void) loadAchievements

{    [GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
	
	if (error != nil)
		;
	// handle errors
	
	if (achievements != nil)
		for (GKAchievement* achievement in achievements);
	//[achievementsDictionary setObject: achievement forKey: achievement.identifier];
	// process the array of achievements.
	
}];
	
}

//NUNCA CREAR UN GKAchievement DIRECTAMENTE, LLAMAR A ESTE MÉTODO
- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier

{
	
    //GKAchievement *achievement = [achievementsDictionary objectForKey:identifier];
	
	/* if (achievement == nil);
	 
	 {
	 
	 achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
	 
	 [achievementsDictionary setObject:achievement forKey:achievement.identifier];
	 
	 }
	 
	 return [[achievement retain] autorelease];*/
	return nil;
	
}

- (void) resetAchievements

{
	
	// Clear all locally saved achievement objects.
	
    //achievementsDictionary = [[NSMutableDictionary alloc] init];
	
	// Clear all progress saved on Game Center
	
	[GKAchievement resetAchievementsWithCompletionHandler:^(NSError *error)
	 
	 {
		 
		 if (error != nil)
			 ;
		 // handle errors
		 
	 }];
	
}

- (void) showAchievements

{
	
    GKAchievementViewController *achievements = [[GKAchievementViewController alloc] init];
	
    if (achievements != nil)
		
    {
		
        achievements.achievementDelegate = self;
		[[NSNotificationCenter defaultCenter] postNotificationName:@"showUIView" object:achievements];
        //[self presentModalViewController: achievements animated: YES];
		
    }
	
    [achievements release];
	
}



-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController{
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
}

@end
