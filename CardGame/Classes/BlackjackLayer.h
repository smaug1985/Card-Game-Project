//
//  BlackjackLayer.h
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "Blackjack.h"
#import "GameSettings.h"
#import "Chip.h"
#import "BJChipsLayer.h"
#import "BJChipsBetLayer.h"
#import "BJCardLayer.h"
#import "ModalMenuLayer.h"
#import "BlackJackSettings.h"
#import "PauseMenuLayer.h"
#import "Packet.h"
#import "GameCenter.h"

@interface BlackjackLayer : CCLayer <BlackjackEvents, ModalMenuEvents, CardLayerEvents, PauseMenuEvents, GKMatchDelegate, GameCenterEvents> {

	BlackJackSettings *bjprefs;
	int64_t localPlayerScore;
	
	Blackjack *blackjack;
	ModalMenuLayer *modalMenu;
	
	BJChipsLayer *chipsLayer;
	BJChipsBetLayer *chipsBetLayer;
	BJCardLayer *cardLayer;
	PauseMenuLayer *pauseLayer;
	CCMenuItemLabel *pauseButton;
	
	GameCenter *gc;
	
	bool menuIsHide;
	
	//multi
	GKMatch *myMatch;
	GKVoiceChat *allChannel;
	
}

@property (nonatomic, retain) Blackjack *blackjack;
@property (nonatomic, retain) ModalMenuLayer *modalMenu;

@property (nonatomic, retain) BJChipsLayer *chipsLayer;
@property (nonatomic, retain) BJChipsBetLayer *chipsBetLayer;
@property (nonatomic, retain) BJCardLayer *cardLayer;
@property (nonatomic, retain) PauseMenuLayer *pauseLayer;
@property (nonatomic, retain) CCMenuItemLabel *pauseButton;

@property (nonatomic, retain) GKMatch *myMatch;
@property (nonatomic,retain) GKVoiceChat *allChannel;

@property (nonatomic,retain) GameCenter *gc;
@property (nonatomic,assign) int64_t localPlayerScore;

- (void) drawDealer;
- (void) drawPlayerNames;
- (void) drawPlayerMoney;
//inicializa el layer de las fichas y lo añade como hijo
- (void) drawChips;

//inicializa el layer de las apuestas y lo añade como hijo
- (void) drawBet;
- (void) updatePlayerMoneyLabels:(PlayerBJ *)player;
- (void) drawCards;
- (void) dealerAction;
- (void) updatePlayerStatus;
- (void) restartGame;
- (void) playerLosed:(PlayerBJ *)player;
- (void) pause;
-(int) getPuntuation:(PlayerBJ *)player;


//multi

- (void) loadPlayerData:(NSArray *)identifiers;
- (void) cancelFindingProgramaticMatch;
- (void) startVoiceChat;
- (void) stopVoiceChat;
- (void) mutePlayer:(NSString *) inPlayerID;
- (id) initWithMatch:(GKMatch *) aMatch;
-(void) pruevaEnvio;
- (void) sendPacketofType: (PacketType)aType;
- (void) disconnect;

@end
