//
//  typeGameBJLayer.h
//  optionsBJ
//
//  Created by Acquamedia on 05/10/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "BlackJackSettings.h"

@class BlackJackSettings;
@class CustomSetting;

@interface BJSettingsLayer : CCLayer
{
	BlackJackSettings *set;
	CCMenuItemToggle *customOp1; //Fall
	CCMenuItemToggle *customOp2; //Double
	CCMenuItemToggle *customOp3; //Split
	CCMenuItemToggle *option1; //European, american and custom
	
	CCSprite *background;
	CCMenu *menu;
	
	bool isShowing;

}

@property (nonatomic,assign) bool isShowing;

-(void) showSettings;

@end
