//
//  PlayerBJ.m
//  Cartas
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PlayerBJ.h"


@implementation PlayerBJ

@synthesize secondHand, bet,insurance,chipsBet10,chipsBet25,chipsBet100,chipsBet200,chipsBet500, status, isReady, playerHash, isHost, isReadyForPositions;

-(id) initWithName:(NSString *)name position:(PositionInTable)pos money:(int)amount bet:(int)amount2{
	if((self = [super initWithName:name position:pos money:amount])){
		self.bet = amount2;
		self.secondHand = [NSMutableArray array];
		self.status = PlayerUnderPuntuation;
		
		[self getChipsBet];
		
	}
	return self;
}
/* Return the player score for the hand. 
   Return -1 if the player has a BlackJack
 */
-(int)playerHandPuntuation:(PlayerHand) hand{
	int total = 0;
	int aceCount = 0;
	BOOL hasAce = NO;
	NSArray *selectedHand = nil;
	
	switch (hand) {
		case PlayerHandFirst:
			selectedHand = self.playerHand;
			break;
		case PlayerHandSecond:
			selectedHand = self.secondHand;
			break;
	}
	
	for (Card *card in selectedHand) {
		if([card.num isEqualToString:@"A"]){
			aceCount++;
			hasAce = YES;
		}
		total += card.valor;
	}
		
	if(hasAce){
		for(int i=0;i<aceCount;i++){
			if(total>21)
				total -=10;
		}
	}
	if(total == 21 && [selectedHand count] == 2) return -1;
	return total;
}

-(void) addCard:(Card *)card toHand: (PlayerHand) hand{
	switch (hand) {
		case PlayerHandFirst:
			[super addCard:card];
			break;
		case PlayerHandSecond:
			[secondHand addObject:card];
			break;
	}

}
-(void) cleanHand:(PlayerHand) hand{
	switch (hand) {
		case PlayerHandFirst:
			[super cleanHand];
			break;
		case PlayerHandSecond:{
			
			NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
			self.secondHand = tmpArray;
			[tmpArray release];
			break;
		}
			
	}
}

-(void) getChipsBet {	
	self.chipsBet10 =0;
	self.chipsBet25 =0;
	self.chipsBet100 =0;
	self.chipsBet200 =0;
	self.chipsBet500 =0;
	
	if (self.bet/1000 >= 1){
		int miles = self.bet/1000;
		self.chipsBet10 = miles*5;
		self.chipsBet25 = miles*2;
		self.chipsBet100 = miles*2;
		self.chipsBet200 = miles*1;
		self.chipsBet500 = miles*1;
	}
	
	if (self.bet%1000 != 0) {
		
		int resto = self.bet%1000;
		
		while (resto >= 10) {
			if (resto >= 500) {
				self.chipsBet500 = self.chipsBet500+1;
				resto = resto-500;
			}
			else if (resto >=200 ) {
				self.chipsBet200 = self.chipsBet200+1;
				resto = resto-200;
			}
			else if (resto >=100 ) {
				self.chipsBet100 = self.chipsBet100+1;
				resto = resto-100;
			}
			else if (resto >=25 ) {
				self.chipsBet25 = self.chipsBet25+1;
				resto = resto-25;
			}
			else if (resto >=10 ) {
				self.chipsBet10 = self.chipsBet10+1;
				resto = resto-10;
			}
		}
	}
	
}

-(void) dealloc{
	[super dealloc];
}


@end
