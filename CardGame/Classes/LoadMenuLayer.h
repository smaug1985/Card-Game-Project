//
//  LoadMenuLayer.h
//  CardGame
//
//  Created by gali on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>


@protocol LoadMenuEvents <NSObject>

-(void) cancelLoad;

@end


@interface LoadMenuLayer : CCLayer {
	
	id<LoadMenuEvents> delegate;
	CCSprite *background;
	CCMenu *menu;
	CCMenuItemLabel *cancelButton;
	CCMenuItemLabel *LoadButton;
	CCLabel *loadLabel;
	GKMatchRequest *request;

}

@property (nonatomic,retain) id<LoadMenuEvents> delegate;
@property (nonatomic,retain) CCSprite *background;
@property (nonatomic,retain) CCMenu *menu;
@property (nonatomic,retain) CCMenuItemLabel *cancelButton;
@property (nonatomic,retain) CCLabel *loadLabel;
@property (nonatomic,retain) GKMatchRequest *request;


-(void) cancelMenu;
- (void) showLoadMenuWithRequest: (GKMatchRequest *) aRequest;
-(void) hideLoadMenu;
-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled;

@end
