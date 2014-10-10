//
//  PauseMenuLayer.h
//  CardGame
//
//  Created by Fran on 14/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MainScene.h"

@protocol PauseMenuEvents <NSObject>

-(void) resumePause;
-(void) exitPause;

@end


@interface PauseMenuLayer : CCLayer {
	
	id<PauseMenuEvents> delegate;
	CCSprite *background;
	CCMenu *menu;
	CCMenuItemLabel *resumeButton;
	CCMenuItemLabel *exitButton;

}

@property (nonatomic,retain) id<PauseMenuEvents> delegate;
@property (nonatomic,retain) CCSprite *background;
@property (nonatomic,retain) CCMenu *menu;
@property (nonatomic,retain) CCMenuItemLabel *resumeButton;
@property (nonatomic,retain) CCMenuItemLabel *exitButton;

-(void) exitPlayer;
-(void) resumePlayer;
- (void) showPauseMenu;
-(void) hidePauseMenu;
-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled;

@end
