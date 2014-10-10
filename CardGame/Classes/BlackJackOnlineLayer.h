//
//  BlackJackOnlineLayer.h
//  CardGame
//
//  Created by ender on 15/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
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
#import <GameKit/GameKit.h>
#import "Packet.h"
#import "PlayerBJ.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MainScene.h"
#import "WinWithBJ.h"

@interface BlackJackOnlineLayer : CCLayer <BlackjackEvents, ModalMenuEvents, CardLayerEvents, PauseMenuEvents, GKMatchDelegate, GameCenterEvents>{
	
	BlackJackSettings *bjprefs;
	
	Blackjack *blackjack;
	ModalMenuLayer *modalMenu;
	
	BJChipsLayer *chipsLayer;
	BJChipsBetLayer *chipsBetLayer;
	BJCardLayer *cardLayer;
	PauseMenuLayer *pauseLayer;
	CCMenuItemLabel *pauseButton;
	
	bool menuIsHide;
	int64_t localPlayerScore;

	WinWithBJ * winWithBJ;
	GameCenter *gc;
	
	//multi
	GKMatch *myMatch;
	GKVoiceChat *allChannel;
	BOOL isHost;
}

@property (nonatomic, retain) Blackjack *blackjack;
@property (nonatomic, retain) ModalMenuLayer *modalMenu;
@property (nonatomic,assign) int64_t localPlayerScore;
@property (nonatomic,retain) GameCenter *gc;

@property (nonatomic, retain) BJChipsLayer *chipsLayer;
@property (nonatomic, retain) BJChipsBetLayer *chipsBetLayer;
@property (nonatomic, retain) BJCardLayer *cardLayer;
@property (nonatomic, retain) PauseMenuLayer *pauseLayer;
@property (nonatomic, retain) CCMenuItemLabel *pauseButton;

@property (nonatomic, retain) GKMatch *myMatch;
@property (nonatomic,retain) GKVoiceChat *allChannel;
@property (nonatomic,assign) BOOL isHost;


@property (nonatomic, retain) WinWithBJ * winWithBJ;

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


//multi

- (void) loadPlayerData:(NSArray *)identifiers;
- (void) cancelFindingProgramaticMatch;
- (void) startVoiceChat;
- (void) stopVoiceChat;
- (void) mutePlayer:(NSString *) inPlayerID;
- (id) initWithMatch:(GKMatch *) aMatch;
-(void) pruevaEnvio;
- (void) sendPacketofType: (PacketType)aType;
- (void) sendPacketofType: (PacketType)aType withBet:(int) bet;
- (void) disconnect;
-(BOOL) checkIfPlayersAreReady;
-(void) buildPacketForCard:(Card *) card1 packet:(CardPacket) msg1;
- (void) sendPacketWithCard1:(Card*) card1 toPlayer:(NSString *) playerID withTarget:(int) targetHash message:(BOOL) message;
- (void) sendPacketWithPosition:(PositionInTable) pos ofPlayer:(NSString *) playerID;

- (PlayerBJ *) localPlayer;

@end
