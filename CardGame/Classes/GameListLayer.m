//
//  HelloWorldLayer.m
//  ExampleCocos2D
//
//  Created by gali on 25/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "GameListLayer.h"

// HelloWorld implementation
@implementation GameListLayer
@synthesize menu,background;

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		// create and initialize a Label
		CCLabel* title = [CCLabel labelWithString:@"Selecciona un juego " fontName:@"Royalacid" fontSize:35];
		
		// position the label on the center of the screen
		title.position =  ccp( s.width /2 , s.height-title.contentSize.height );
		
		[self addChild:title];
		
		CCMenuItemLabel *item1 = [CCMenuItemImage itemFromNormalImage:@"blackjack.png" selectedImage:@"blackjackOver.png" target:self selector:@selector(item1)];
		//CCMenuItemLabel *item2 = [CCMenuItemImage itemFromNormalImage:@"cartamasalta.png" selectedImage:@"cartamasaltaOver.png" target:self selector:@selector(item2)];
		
		self.menu = [CCMenu menuWithItems:item1/*,item2*/, nil];
		
		//self.menu.anchorPoint = ccp(0, self.menu.contentSize.height);
		self.menu.position = ccp(s.width/2, s.height/2-70);
		
		[self.menu alignItemsInRows:[NSNumber numberWithInt:1],[NSNumber numberWithInt:1],nil];
		
		[self addChild:self.menu];
		
		CCMenuItemLabel *backItem = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrowOver.png" target:self selector:@selector(backItem)];
		CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
		backMenu.position = ccp(backItem.contentSize.width/2, backItem.contentSize.height/2);
		
		[self addChild:backMenu];
		
	}
	return self;
}

/*-(void) alignMenusH
{
		CCMenu *menu = (CCMenu*)[self getChildByTag:100];
		menu.position = centeredMenu;
		if(i==0) {
			// TIP: if no padding, padding = 5
			[menu alignItemsHorizontally];			
			CGPoint p = menu.position;
			menu.position = ccpAdd(p, ccp(0,30));
	

}*/

/*
-(void) disableMenu:(BOOL) disabled{
	
	NSArray *ar=[menu children];
	for(CCMenuItemFont *item in ar)
		[item setIsEnabled:!disabled];
}
*/


-(void)item1{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"blackjackDes" object:@""];
}

-(void)item2{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"" object:@""];
}

-(void) backItem{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"backMenuFromRight" object:@""];
}

+ (CCMenuItemFont *) getSpacerItem
{
	[CCMenuItemFont setFontSize:2];
	return [CCMenuItemFont itemFromString:@" " target:self selector:nil];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	[menu release];
	[background release];
	//[super dealloc];
}
@end
