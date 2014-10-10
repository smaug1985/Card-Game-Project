//
//  ModalMenuLayer.h
//  CardGame
//
//  Created by Fran on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerBJ.h"
#import "BlackJackSettings.h"

#define DELAYANIMATION 0.5
#define DELAYBACK 0.2
#define DELAYCONTENT 0.5
#define DURATIONBACK 0.5
#define DURATIONCONTENT 0.2

typedef enum {
	BetMenu,
	ActionMenu,
	CompareMenu
}ModalMenuClass;

@protocol ModalMenuEvents <NSObject>

-(void) betMade:(int)bet byPlayer:(PlayerBJ *)p;
-(void) menuIsHide:(bool)status;
-(void) cardButtonPushedBy:(PlayerBJ *)p;
-(void) continueButtonPushedBy:(PlayerBJ *)p;
-(void) doubleBetButtonPushedBy:(PlayerBJ *)p;
-(void) compareWithDealerMade:(PlayerBJ *)p;

@end

@interface ModalMenuLayer : CCLayer {

	BlackJackSettings *bjprefs;
	
	int bet;
	id<ModalMenuEvents> delegate;
	
	CCSprite *background;
	
	CCMenu *menu;
	CCMenu *menuGame;
	CCMenu *menuCompare;
	
	//Elementos menu apuesta
	CCMenuItemImage *chip10Button;
	CCMenuItemImage *chip25Button;
	CCMenuItemImage *chip100Button;
	CCMenuItemImage *chip200Button;
	CCMenuItemImage *chip500Button;
	CCMenuItemLabel *restartButton;
	CCMenuItemLabel *makeBetButton;
	CCMenuItemLabel *clearBetButton;
	
	//Elementos menu accion
	CCMenuItemLabel *doubleButton;
	CCMenuItemLabel *callCardButton;
	CCMenuItemLabel *standButton;
	CCMenuItemLabel *okButton;
	
	
	//Elementos menu compare
	CCLabel *dealerName;
	CCMenuItemLabel *continueButton;
	CCLabel *playerScore;
	CCLabel *dealerScore;
	
	
	CCLabel *nameLabel;
	
	CCLabel *betLabel;
	
	PlayerBJ *player;
	PlayerBJ *dealer;
	
	ModalMenuClass mmclass;
	PlayerResult result;
	
}

@property (nonatomic, assign) int bet;
@property (nonatomic,retain) id<ModalMenuEvents> delegate;

@property (nonatomic,retain) CCSprite *background;

@property (nonatomic,retain) CCMenu *menu;
@property (nonatomic,retain) CCMenu *menuGame;
@property (nonatomic,retain) CCMenu *menuCompare;

//Elementos menu apuesta
@property (nonatomic,retain) CCMenuItemImage *chip10Button;
@property (nonatomic,retain) CCMenuItemImage *chip25Button;
@property (nonatomic,retain) CCMenuItemImage *chip100Button;
@property (nonatomic,retain) CCMenuItemImage *chip200Button;
@property (nonatomic,retain) CCMenuItemImage *chip500Button;
@property (nonatomic,retain) CCMenuItemLabel *restartButton;
@property (nonatomic,retain) CCMenuItemLabel *makeBetButton;
@property (nonatomic,retain) CCMenuItemLabel *clearBetButton;
@property (nonatomic,retain) CCLabel *betLabel;

//Elementos menu accion
@property (nonatomic,retain) CCMenuItemLabel *doubleButton;
@property (nonatomic,retain) CCMenuItemLabel *callCardButton;
@property (nonatomic,retain) CCMenuItemLabel *standButton;
@property (nonatomic,retain) CCMenuItemLabel *okButton;


//Elementos menu compare
@property (nonatomic,retain) CCLabel *dealerName;
@property (nonatomic,retain) CCMenuItemLabel *continueButton;
@property (nonatomic,retain) CCLabel *playerScore;
@property (nonatomic,retain) CCLabel *dealerScore;



@property (nonatomic,retain) CCLabel *nameLabel;

@property (nonatomic,retain) PlayerBJ *player;
@property (nonatomic,retain) PlayerBJ *dealer;
@property (nonatomic,assign) PlayerResult result;




- (void) showModalMenuWith:(ModalMenuClass)mmc playerBJ:(PlayerBJ *)p;
-(void) hideModalMenuWith:(ModalMenuClass)mmc;
- (void) hideActionMenu;
- (void) hideCompareMenu;
- (void) makeBet;
- (void) disableMenu:(CCMenu *)m set:(BOOL) disabled;
- (void) showCompareMenu:(PlayerBJ *)p dealer:(PlayerBJ *)d result:(PlayerResult)r;

@end
