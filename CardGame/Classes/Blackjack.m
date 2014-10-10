//
//  Blackjack.m
//  CardGame
//
//  Created by Borja Rubio Soler on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Blackjack.h"


@implementation Blackjack

@synthesize deck,dealer,players,delegate;

#pragma mark Constructors
-(id)init{
	return [self initWithDeck:nil];
}
-(id) initWithDeck:(Deck *) aDeck{
	return [self initWithDeck:aDeck listOfPlayers:nil];
}
-(id) initWithPlayers:(NSMutableArray *) list{
	return [self initWithDeck:nil listOfPlayers:list];
	
}
-(id) initWithDeck:(Deck *) aDeck listOfPlayers:(NSMutableArray *)list{

	if((self = [super init])){
		self.deck = aDeck;
		self.players = list;
		PlayerBJ *tmpPlayer = [[PlayerBJ alloc] initWithName:NSLocalizedString(@"dealer",@"Dealer") position:PositionInTableTop];
		self.dealer = tmpPlayer;
		[tmpPlayer release];
	}
	return self;
}

-(void) bet:(int)amount player:(PlayerBJ *)player{
	player.bet = amount;
	[player getChips];
	[player getChipsBet];
	if([delegate respondsToSelector:@selector(playerBetted:blackjack:)]){
		[delegate playerBetted:player blackjack:self];
	}
}

-(void) addBet:(int)amount player:(PlayerBJ *)player{
	player.money -= amount;
	[self bet:(player.bet+amount) player:player];
}

-(void) giveCard:(int)n to:(PlayerBJ *)player{
	[self giveCard:n to:player toHand:PlayerHandFirst];
}

-(void) giveCard:(int)n to:(PlayerBJ *)player toHand:(PlayerHand) hand{
	for(int i=0;i<n;i++){
		Card *card=[deck pop];
		if(card==nil){
			if([delegate respondsToSelector:@selector(deckIsVoid:)]){
				[delegate deckIsVoid:self];
			}
			break;
		}
		[player addCard:card toHand:hand];
		if([delegate respondsToSelector:@selector(playerGotCard:toPlayer:blackjack:message:)]){
			[delegate playerGotCard:card toPlayer:player blackjack:self message:YES];
		}
	}
}

-(PlayerStatus) checkPlayerHand:(PlayerBJ *)player{
	return [self checkPlayerHand:player toHand:PlayerHandFirst];
}
-(PlayerStatus) checkPlayerHand:(PlayerBJ *)player toHand:(PlayerHand)hand{
	int score=[player playerHandPuntuation:hand];
	if(score == -1){
		return PlayerHasBlackjack;
	}else if(score > 21){
		return PlayerBusted;
	}else if(score == 21){
		return PlayerHas21;
	}else {
		return PlayerUnderPuntuation;
	}
}

-(BOOL) playerCanSplit:(PlayerBJ *)player{

	if([player.playerHand count]==2){
		Card *card1 = [player.playerHand objectAtIndex:0];
		Card *card2 = [player.playerHand objectAtIndex:1];
		if(card1.valor ==  card2.valor)
			return YES;
	}
	return NO;
}

-(void) playerSplit:(PlayerBJ *)player{
	Card *card1 = [player.playerHand objectAtIndex:0];
	Card *card2 = [player.playerHand objectAtIndex:1];
	[player cleanHand:PlayerHandFirst];
	[player cleanHand:PlayerHandFirst];
	[player addCard:card1 toHand:PlayerHandFirst];
	[player addCard:card2 toHand:PlayerHandSecond];
	
	if([delegate respondsToSelector:@selector(playerSplited:blackjack:)]){
		[delegate playerSplited:player blackjack:self];
	}
}

- (void) playerWin:(PlayerBJ *)player{

	if (player.status == PlayerHasBlackjack) {
		player.money += (player.bet*2 + player.bet/2);
	}else {
		NSLog(@"Jugador %@ gana",player.playerName);
		player.money += player.bet*2;
	}

	
	//[player cleanHand:PlayerHandFirst];
	//[player cleanHand:PlayerHandSecond];
	//player.bet = 0;
	
}

- (void) playerLose:(PlayerBJ *)player{

	NSLog(@"Jugador %@ pierde",player.playerName);
	
	//[player cleanHand:PlayerHandFirst];
	//[player cleanHand:PlayerHandSecond];
	//player.bet = 0;

}

- (void) playerTie:(PlayerBJ *)player{

	NSLog(@"Jugador %@ empata",player.playerName);
	player.money += player.bet;
	//[player cleanHand:PlayerHandFirst];
	//[player cleanHand:PlayerHandSecond];
	//player.bet = 0;

}

-(void)cleanPlayer:(PlayerBJ *)player{
	
	[player cleanHand:PlayerHandFirst];
	[player cleanHand:PlayerHandSecond];
	player.bet = 0;
	
}

- (PlayerResult) comparePlayerWithDealer:(PlayerBJ *)player{

	if (player.status == PlayerHasBlackjack) {
		
		if (player.status == self.dealer.status) {
			return PlayerTie;
		}else {
			return PlayerWin;
		}
		
	}else if (player.status == PlayerBusted) {
		
	
			return PlayerLose;
		
	
	}else if (player.status == PlayerHas21) {
		
		if (dealer.status == PlayerHasBlackjack) {
			
			return PlayerLose;
			
		}else if (player.status == self.dealer.status) {
			
			return PlayerTie;
			
		}else {
			
			return PlayerWin;
			
		}
		
	}else{
		
		int pPuntuation = [player playerHandPuntuation:PlayerHandFirst];
		int dPuntuation = [self.dealer playerHandPuntuation:PlayerHandFirst];
		
		if(self.dealer.status == PlayerHasBlackjack){
		
			return PlayerLose;
		
		}else if (pPuntuation < dPuntuation) {
			
			if (dealer.status == PlayerBusted) {
				return PlayerWin;
			}else {
				return PlayerLose;
			}
			
		}else if(pPuntuation > dPuntuation){
			
			return PlayerWin;
			
		}else {
			return PlayerTie;
		}


		
	}

}

-(void) comparePlayerWithDealerAndDealMoney:(PlayerBJ *)player{

	if (player.status == PlayerHasBlackjack) {
		
		if (player.status == self.dealer.status) {
			[self playerTie:player];
			
		}else {
			[self playerWin:player];
		}
		
	}else if (player.status == PlayerBusted) {
		
		
		
		[self playerLose:player];
		
		
	}else if (player.status == PlayerHas21) {
		
		if (dealer.status == PlayerHasBlackjack) {
			
			[self playerLose:player];
			
		}else if (player.status == self.dealer.status) {
			
			[self playerTie:player];
			
		}else {
			
			[self playerWin:player];
			
		}
		
	}else{
		
		int pPuntuation = [player playerHandPuntuation:PlayerHandFirst];
		int dPuntuation = [self.dealer playerHandPuntuation:PlayerHandFirst];
		
		if(self.dealer.status == PlayerHasBlackjack){
			
			[self playerLose:player];
			
		}else if (pPuntuation < dPuntuation) {
			
			if (dealer.status == PlayerBusted) {
				[self playerWin:player];
			}else {
				[self playerLose:player];
			}
			
		}else if(pPuntuation > dPuntuation){
			
			[self playerWin:player];
			
		}else {
			[self playerTie:player];
		}
		
		
		
	}

}

-(void)removePlayer:(PlayerBJ *)player{

	[self.players removeObject:player];

}


-(PlayerBJ *) getPlayerAtPosition:(PositionInTable) position{
	
	for (PlayerBJ* p in players) {
		if(p.position == position)
			return p;
	}
	return nil;
	
	
}


-(PlayerBJ *) getPlayerById:(NSString *) aPlayerID{
	for (PlayerBJ* p in players) {
		if([p.playerID isEqualToString:aPlayerID])
			return p;
	}
	return nil;
	
}

-(PlayerBJ *) getPlayerByHash:(int) aPlayerHash
{
	for (PlayerBJ* p in players) {
		if(p.playerHash == aPlayerHash)
			return p;
	}
	return nil;
	
}

-(Card *) getCardWithNumber:(int) cardNumber palo:(CardPalo) palo{
	NSString *strTmp = [NSString stringWithFormat:@"%d",cardNumber];
	if (cardNumber == 11) {
		strTmp = @"J";
	}
	else if (cardNumber == 12){
		strTmp = @"Q";
	}
	else if (cardNumber == 13){
		strTmp = @"K";
	}
	else if (cardNumber == 14){
		strTmp = @"A";
	}
	
switch (palo) {
		

	case paloCorazon:
		for (Card * card in deck.arrayCards) {
			if ([card.num isEqualToString:strTmp]) {
				//ha encontrado una carta del mismo número
				if ([card.palo isEqualToString:@"corazon"]) {
					[[card retain] autorelease];
					[deck.arrayCards removeObject:card];
					
					return card;
					
				}
			}
		}
		break;
		
	case PaloDiamante:
		for (Card * card in deck.arrayCards) {
			if ([card.num isEqualToString:strTmp]) {
				//ha encontrado una carta del mismo número
				if ([card.palo isEqualToString:@"diamante"]) {
					[[card retain] autorelease];
					[deck.arrayCards removeObject:card];
					


					return card;
				}
			}
		}
		break;
	case PaloPica:
		for (Card * card in deck.arrayCards) {
			if ([card.num isEqualToString:strTmp]) {
				//ha encontrado una carta del mismo número
				if ([card.palo isEqualToString:@"pica"]) {
					[[card retain] autorelease];
					[deck.arrayCards removeObject:card];

					return card;
				}
			}
		}
		break;
		
	case PaloTrebol:
		for (Card * card in deck.arrayCards) {
			if ([card.num isEqualToString:strTmp]) {
				//ha encontrado una carta del mismo número
				if ([card.palo isEqualToString:@"trebol"]) {
					[[card retain] autorelease];
					[deck.arrayCards removeObject:card];

					return card;
				}
			}
		}
		break;
	default:
		return nil;
		break;
}
	
	
}


@end
