//
//  PlayerBJ.h
//  Cartas
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
//#import "Blackjack.h"
//@class Blackjack;

typedef enum{
	PlayerHandFirst,
	PlayerHandSecond
}PlayerHand;


typedef enum {
	PlayerHasBlackjack,
	PlayerBusted,
	PlayerUnderPuntuation,
	PlayerHas21
}PlayerStatus;

typedef enum {
	PlayerWin,
	PlayerLose,
	PlayerTie
}PlayerResult;

@interface PlayerBJ : Player {

	NSMutableArray *secondHand;
	int bet;
	BOOL insurance;
	BOOL isReady;
	BOOL isHost;
	BOOL isReadyForPositions;

	int chipsBet10;
	int chipsBet25;
	int chipsBet100;
	int chipsBet200;
	int chipsBet500;
	
	int playerHash;
	PlayerStatus status;
}
@property (nonatomic, retain) NSMutableArray *secondHand;
@property (nonatomic, assign) int bet;
@property (nonatomic, assign) int playerHash;
@property (nonatomic, assign) BOOL insurance;
@property (nonatomic, assign) BOOL isReadyForPositions;
@property (nonatomic, assign) BOOL isReady;
@property (nonatomic, assign) BOOL isHost;
@property (nonatomic, assign) int chipsBet10;
@property (nonatomic, assign) int chipsBet25;
@property (nonatomic, assign) int chipsBet100;
@property (nonatomic, assign) int chipsBet200;
@property (nonatomic, assign) int chipsBet500;
@property (nonatomic, assign) PlayerStatus status;


-(id) initWithName:(NSString *)name position:(PositionInTable)pos money:(int)amount bet:(int)amount2;
-(int) playerHandPuntuation:(PlayerHand) hand;
-(void) addCard:(Card *)card toHand: (PlayerHand) hand;
-(void) cleanHand:(PlayerHand) hand;
-(void) getChipsBet;



@end
