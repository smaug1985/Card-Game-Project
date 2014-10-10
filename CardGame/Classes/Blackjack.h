//
//  Blackjack.h
//  CardGame
//
//  Created by Borja Rubio Soler on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlayerBJ.h"
#import "Deck.h"
#import "Packet.h"

@protocol BlackjackEvents<NSObject>

-(void) deckIsVoid:(id) bj;
-(void) playerIsReady:(PlayerBJ *) player blackjack:(id)bj;
-(void) playerBetted:(PlayerBJ *)player blackjack:(id)bj;
-(void) playerGotCard:(Card *)card toPlayer:(PlayerBJ *)player blackjack:(id)bj message:(BOOL) message;
-(void) playerSplited:(PlayerBJ *)player blackjack:(id)bj;
-(void) sendResult;

//-(void) player:(PlayerBJ *)player withResult:(PlayerResult)result blackjack:(id)bj;

@end

@interface Blackjack : NSObject {

	NSMutableArray *players;
	PlayerBJ *dealer;
	Deck *deck;
	id<BlackjackEvents> delegate;
	
	
}
@property (nonatomic,retain) NSMutableArray *players;
@property (nonatomic,retain) PlayerBJ *dealer;
@property (nonatomic,retain) Deck *deck;
@property (nonatomic,retain) id<BlackjackEvents> delegate;

// Init Methods
-(id) initWithDeck:(Deck *) aDeck;
-(id) initWithPlayers:(NSMutableArray *) list;
-(id) initWithDeck:(Deck *) aDeck listOfPlayers:(NSMutableArray *)list;


-(void) bet:(int)amount player:(PlayerBJ *)player;
-(void) addBet:(int)amount player:(PlayerBJ *)player;
-(void) giveCard:(int)n to:(PlayerBJ *)player;
-(void) giveCard:(int)n to:(PlayerBJ *)player toHand:(PlayerHand) hand;
-(PlayerStatus) checkPlayerHand:(PlayerBJ *)player;
-(PlayerStatus) checkPlayerHand:(PlayerBJ *)player toHand:(PlayerHand)hand;
-(BOOL) playerCanSplit:(PlayerBJ *)player;
-(void)playerWin:(PlayerBJ *)player;
-(void)playerLose:(PlayerBJ *)player;
-(void)playerTie:(PlayerBJ *)player;
-(void)cleanPlayer:(PlayerBJ *)player;
-(PlayerResult)comparePlayerWithDealer:(PlayerBJ *)player;
-(void) comparePlayerWithDealerAndDealMoney:(PlayerBJ *)player;
-(void)removePlayer:(PlayerBJ *)player;

-(PlayerBJ *) getPlayerAtPosition:(PositionInTable) position;
-(PlayerBJ *) getPlayerById:(NSString *) aPlayerID;
-(PlayerBJ *) getPlayerByHash:(int) aPlayerHash;
-(Card *) getCardWithNumber:(int) cardNumber palo:(CardPalo) palo;
	


@end


