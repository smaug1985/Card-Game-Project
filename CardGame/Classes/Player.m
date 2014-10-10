//
//  Player.m
//  Cartas
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Player.h"


@implementation Player

@synthesize playerName, playerHand, position,money;
@synthesize chips10,chips25,chips100,chips200,chips500;
@synthesize chipsBet10,chipsBet25,chipsBet100,chipsBet200,chipsBet500;
@synthesize playerID, isMuted;

-(id) initWithName: (NSString *) name position:(PositionInTable) pos money:(int)amount{
	if((self=[super init])){
		self.playerName = name;
		self.position = pos;
		self.money = amount;
		self.playerHand = [NSMutableArray array];
		
		[self getChips];
	}
	return self;
}
-(id) initWithName: (NSString *) name position:(PositionInTable) pos{
	
	return [self initWithName:name position:pos money:0];

}

-(id) initWithName: (NSString *) name{
	
	return [self initWithName:name position:PositionInTableBottom];
	
}


-(void) cleanHand{
	NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
	self.playerHand = tmpArray;
	[tmpArray release];
}

-(void) addCard:(Card *) card{
	[playerHand addObject:card];
}

-(void) getChips{
	self.chips10 =0;
	self.chips25 =0;
	self.chips100 =0;
	self.chips200 =0;
	self.chips500 =0;
	
	if (self.money/1000 >= 1){
			int miles = self.money/1000;
			self.chips10 = miles*5;
			self.chips25 = miles*2;
			self.chips100 = miles*2;
			self.chips200 = miles*1;
			self.chips500 = miles*1;
	}
			
	if (self.money%1000 != 0) {
			
		int resto = self.money%1000;
				
		while (resto >= 10) {
			if (resto >= 500) {
				self.chips500 = self.chips500+1;
				resto = resto-500;
			}
			else if (resto >=200 ) {
				self.chips200 = self.chips200+1;
				resto = resto-200;
			}
			else if (resto >=100 ) {
				self.chips100 = self.chips100+1;
				resto = resto-100;
			}
			else if (resto >=25 ) {
				self.chips25 = self.chips25+1;
				resto = resto-25;
			}
			else if (resto >=10 ) {
				self.chips10 = self.chips10+1;
				resto = resto-10;
			}
		}
	}
}

//Para carcular una cantidad indicada
-(NSArray *)getChipsFor:(int)i{

	NSArray *fichas = [NSArray array];
	
	return fichas;

}

-(void) dealloc{
	
	[super dealloc];
}


@end
