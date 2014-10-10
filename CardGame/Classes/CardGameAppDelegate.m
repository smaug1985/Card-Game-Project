//
//  CardGameAppDelegate.m
//  CardGame
//
//  Created by Fran on 28/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "CardGameAppDelegate.h"
#import "cocos2d.h"
#import "MainScene.h"
#import "SimpleAudioEngine.h"


@implementation CardGameAppDelegate

@synthesize window;
@synthesize notifyCenter;
@synthesize achievementsDictionary;

- (void) applicationDidFinishLaunching:(UIApplication*)application
{
	
	self.notifyCenter = [NSNotificationCenter defaultCenter];
	[notifyCenter addObserver:self selector:@selector(trackNotifications:) name:nil object:nil];
	
	// CC_DIRECTOR_INIT()
	//
	// 1. Initializes an EAGLView with 0-bit depth format, and RGB565 render buffer
	// 2. EAGLView multiple touches: disabled
	// 3. creates a UIWindow, and assign it to the "window" var (it must already be declared)
	// 4. Parents EAGLView to the newly created window
	// 5. Creates Display Link Director
	// 5a. If it fails, it will use an NSTimer director
	// 6. It will try to run at 60 FPS
	// 7. Display FPS: NO
	// 8. Device orientation: Portrait
	// 9. Connects the director to the EAGLView
	//
	CC_DIRECTOR_INIT();
	
	// Obtain the shared director in order to...
	CCDirector *director = [CCDirector sharedDirector];
	
	// Sets landscape mode
	[director setDeviceOrientation:kCCDeviceOrientationPortrait];
	
	// Turn on display FPS
	[director setDisplayFPS:NO];
	
	// Turn on multiple touches
	//EAGLView *view = [director openGLView];
	//[view setMultipleTouchEnabled:YES];
	//[view addSubview:imageView];
	//[view sendSubviewToBack:imageView];
	//[view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"table.png"]]];
	
	// Default texture format for PNG/BMP/TIFF/JPEG/GIF images
	// It can be RGBA8888, RGBA4444, RGB5_A1, RGB565
	// You can change anytime.
	[CCTexture2D setDefaultAlphaPixelFormat:kTexture2DPixelFormat_RGBA8888];	
		
	[[CCDirector sharedDirector] runWithScene: [MainScene scene]];
	
	//Obtengo las preferencias
	/*
	NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
	NSMutableDictionary *dictmp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	self.settings = dictmp;
	[dictmp release];
	
	NSLog(@"Musica %@\n", ([self.settings objectForKey:@"sound"] ? @"YES" : @"NO"));
	NSLog(@"Baraja %@\n", [self.settings objectForKey:@"deck"]);
	*/
	
	[[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"cancion.mp3"];
	
	GameSettings *prefs = [GameSettings sharedSettings];
	
	//Audio
	if (prefs.sound) {
		[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"cancion.mp3"];
	}
	
	[self authenticateLocalPlayer];
	 
}


- (void)applicationWillResignActive:(UIApplication *)application {
	[[CCDirector sharedDirector] pause];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	[[CCDirector sharedDirector] resume];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	//NSLog(@"Memory warning!!!∫");
	[[CCDirector sharedDirector] purgeCachedData];
}

-(void) applicationDidEnterBackground:(UIApplication*)application {
	[[CCDirector sharedDirector] stopAnimation];
}

-(void) applicationWillEnterForeground:(UIApplication*)application {
	[[CCDirector sharedDirector] startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application {
	[[CCDirector sharedDirector] end];
}

- (void)applicationSignificantTimeChange:(UIApplication *)application {
	[[CCDirector sharedDirector] setNextDeltaTimeZero:YES];
}

- (void)dealloc {
	[[CCDirector sharedDirector] release];
	[window release];
	[notifyCenter release];
	[super dealloc];
}

#pragma mark Notifications

- (void) trackNotifications: (NSNotification *) notification{

	GameSettings *prefs = [GameSettings sharedSettings];
	
	NSString *nName = [NSString stringWithString:[notification name]];
	//NSLog(@"%@",nName);
	id obj = [notification object];
	
	if([nName isEqual:@"play"]){
		[MainScene replaceLayer:[GameListLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];
	}
	
	if([nName isEqual:@"scores"]){
		//[MainScene replaceLayer:[GameListLayer node]];
	}
	
	if([nName isEqual:@"settings"]){
		[MainScene replaceLayer:[OptionMenuLayer node] stopAnimation:NO withAnimation:@"MoveZoomToRight"];
	}
	
	if([nName isEqual:@"help"]){
		//[MainScene replaceLayer:[GameListLayer node]];
	}
	
	if([nName isEqual:@"blackjack"]){
		
		//[MainScene fadeOutLayer];
		// Sets landscape mode
		[[CCDirector sharedDirector] setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
		
		//[[CCDirector sharedDirector] replaceScene:[CCSlideInLTransition transitionWithDuration:0.5 scene:[BJScene scene]]];
		[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:0.5 scene:[BJScene scene]]];
		
	}
	
	if([nName isEqual:@"blackjackDes"]){
		[MainScene replaceLayer:[GameDescriptionLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];
	}
	if([nName isEqual:@"backToBlackJackDes"]){
		[MainScene replaceLayer:[GameDescriptionLayer node] stopAnimation:NO withAnimation:@"MoveZoomToRight"];
	}
	
	if([nName isEqual:@"hightestCard"]){
		//[MainScene replaceLayer:[GameListLayer node]];
	}
	
	if([nName isEqual:@"backMenuFromRight"]){
		[MainScene replaceLayer:[MainMenuLayer node] stopAnimation:NO withAnimation:@"MoveZoomToRight"];
	}
	
	if([nName isEqual:@"backGameListFromRight"]){
		[MainScene replaceLayer:[GameListLayer node] stopAnimation:NO withAnimation:@"MoveZoomToRight"];
	}
	
	if([nName isEqual:@"backMenuFromLeft"]){
		[MainScene replaceLayer:[MainMenuLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];
	}
	
	if([nName isEqual:@"backOptionMenu"]){
		[MainScene replaceLayer:[OptionMenuLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];
	}
	
	if([nName isEqual:@"deck"]){
		[MainScene replaceLayer:[OptionDeckLayer node] stopAnimation:NO withAnimation:@"MoveZoomToRight"];
	}
	
	if([nName isEqual:@"changeDeck"]){
		[prefs saveSettings];
		[MainScene replaceLayer:[OptionMenuLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];
	}
	
	if([nName isEqual:@"sound"]){
		if ([[SimpleAudioEngine sharedEngine] isBackgroundMusicPlaying]) {
			prefs.sound = NO;
			[prefs saveSettings];
			[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
		}else {
			prefs.sound = YES;
			[prefs saveSettings];
			[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"motorhead.mp3"];
			
		}

	}
	if([nName isEqual:@"showUIView"]){
		[self showUIViewController:obj];
	}
	if([nName isEqual:@"hideUIView"]){
		[self hideUIViewController:obj];
	}
	if([nName isEqual:@"blackJackPlayOnline"]){
		// remplace Scene
		GKMatch *m = (GKMatch*)obj;
		
		//[MainScene fadeOutLayer];
		[[CCDirector sharedDirector] setDeviceOrientation:kCCDeviceOrientationLandscapeLeft];
		[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:1 scene:[BJScene sceneWithMatch:m isHost:NO]]];
		
		
	}
	if([nName isEqual:@"OnlineMenu"]){
		// remplace Scene
		//[[CCDirector sharedDirector] replaceScene:[CCMoveInBTransition transitionWithDuration:0.5 scene:[GameCenterScene scene]]];
		
		[MainScene replaceLayer:[GameCenterLayer node] stopAnimation:NO withAnimation:@"MoveZoomToLeft"];

	}

}



#pragma mark UIViewController methods

- (void) showUIViewController:(UIViewController *) controller
{
	
	UIViewController *vc = [[UIViewController alloc] init];
	[[[CCDirector sharedDirector] openGLView] addSubview:vc.view];
	[vc presentModalViewController:controller animated:YES];
	
	/*UIViewController *vc = [[UIViewController alloc] init];
	 [[[CCDirector sharedDirector] openGLView] addSubview:vc.view];
	 
	 UIViewAnimationTransition tran = UIViewAnimationTransitionCurlUp;
	 [UIView beginAnimations:nil context:nil];
	 [UIView setAnimationTransition:tran forView:vc.view cache:YES];
	 
	 [vc presentModalViewController:controller animated:NO];
	 
	 [UIView commitAnimations];
	 */
	
	
}

- (void) hideUIViewController:(UIViewController *) controller
{
	
	UIViewController *vc = controller.parentViewController;
	[controller dismissModalViewControllerAnimated:YES];
	[vc.view removeFromSuperview];
	
}

#pragma mark -
#pragma mark Game Center auth methods

- (void) authenticateLocalPlayer

{
	
    [[GKLocalPlayer localPlayer] authenticateWithCompletionHandler:^(NSError *error) {
		
		if (error == nil)
			
		{
			achievementsDictionary = [[NSMutableDictionary alloc] init];
			//[self loadAchievements];
			// Insert code here to handle a successful authentication.
			NSLog(@"Authentication succesful with player: %@", [[GKLocalPlayer localPlayer] alias]);
			
			//manejo de invitaciones pendientes
			[GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
				
				// Insert application-specific code here to clean up any games in progress.
				
				if (acceptedInvite)
					
				{
					
					GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithInvite:acceptedInvite] autorelease];
					
					mmvc.matchmakerDelegate = self;
					[[NSNotificationCenter defaultCenter] postNotificationName:@"showUIView" object:mmvc];
					
				}
				
				else if (playersToInvite)
					
				{
					
					GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
					
					request.minPlayers = 2;
					
					request.maxPlayers = 4;
					
					request.playersToInvite = playersToInvite;
					
					
					
					GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
					
					mmvc.matchmakerDelegate = self;
					[[NSNotificationCenter defaultCenter] postNotificationName:@"showUIView" object:mmvc];
					
				}
				
			};
			
			
			
			
			
		}
		
		else
			
		{
			
			// Your application can process the error parameter to report the error to the player.
			NSLog(@"Authentication failed with error: %@", [error localizedDescription]);
		}
		
	}];
	
}


- (void) registerForAuthenticationNotification

{
	
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
    [nc addObserver: self
	 
           selector:@selector(authenticationChanged)
	 
               name:GKPlayerAuthenticationDidChangeNotificationName
	 
             object:nil];
	
}

- (void) authenticationChanged

{
	
    if ([GKLocalPlayer localPlayer].authenticated ){
		
        // Insert code here to handle a successful authentication.
		NSLog(@"Authentication succesful with player: %@", [[GKLocalPlayer localPlayer] alias]);
		
		
	}
	else;
	
	// Insert code here to clean up any outstanding Game Center-related classes.
	
}

#pragma mark -
#pragma mark Game Center achievements methods

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

{    
	[GKAchievement loadAchievementsWithCompletionHandler:^(NSArray *achievements, NSError *error) {
		
		if (error != nil)
			NSLog(@"error loading achievements: %@", [error localizedDescription]);
		
		// handle errors
		
		if (achievements != nil)
			for (GKAchievement* achievement in achievements)
				[achievementsDictionary setObject: achievement forKey: achievement.identifier];
		// process the array of achievements.
		
	}];
	
}

//NUNCA CREAR UN GKAchievement DIRECTAMENTE, LLAMAR A ESTE MÉTODO
- (GKAchievement*) getAchievementForIdentifier: (NSString*) identifier

{
	
    GKAchievement *achievement = [achievementsDictionary objectForKey:identifier];
	
    if (achievement == nil)
		
    {
		
        achievement = [[[GKAchievement alloc] initWithIdentifier:identifier] autorelease];
		
        [achievementsDictionary setObject:achievement forKey:achievement.identifier];
		
    }
	
    return [[achievement retain] autorelease];
	
}

- (void) resetAchievements

{
	
	// Clear all locally saved achievement objects.
	
    achievementsDictionary = [[NSMutableDictionary alloc] init];
	
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


- (void)achievementViewControllerDidFinish:(GKAchievementViewController *)viewController

{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
	// [self dismissModalViewControllerAnimated:YES];
	
}

#pragma mark MatchMaking methods	

-(void) matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error{
	NSLog(@"Matchmaker did fail with error %@", error);
	
}

-(void) matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController{
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"hideUIView" object:viewController];
}

@end

