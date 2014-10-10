//
//  Player.h
//  Cartas
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Chip.h"

typedef enum {

	PositionInTableRight = 0,
	PositionInTableMiddleRight = 1,
	PositionInTableMiddleLeft = 2,
	PositionInTableLeft = 3,
	PositionInTableBottom = 4,
	PositionInTableTop,
	
}PositionInTable;

@interface Player : NSObject {
	NSString *playerID;
	BOOL isMuted;
	int money;
	NSString *playerName;
	NSMutableArray *playerHand; // Del tipo cards
	PositionInTable position;
	
	int chips10;
	int chips25;
	int chips100;
	int chips200;
	int chips500;
	
	
	
}
@property (nonatomic, retain) NSString *playerID;
@property (nonatomic, assign) BOOL isMuted;


@property (nonatomic, retain) NSString *playerName;
@property (nonatomic, retain) NSMutableArray *playerHand;
@property (nonatomic, assign) PositionInTable position;
@property (nonatomic, assign) int money;

@property (nonatomic, assign) int chips10;
@property (nonatomic, assign) int chips25;
@property (nonatomic, assign) int chips100;
@property (nonatomic, assign) int chips200;
@property (nonatomic, assign) int chips500;

@property (nonatomic, assign) int chipsBet10;
@property (nonatomic, assign) int chipsBet25;
@property (nonatomic, assign) int chipsBet100;
@property (nonatomic, assign) int chipsBet200;
@property (nonatomic, assign) int chipsBet500;

-(void) cleanHand;
-(void) addCard:(Card *) card;
-(id) initWithName: (NSString *) name position:(PositionInTable) pos money:(int)amount;
-(id) initWithName: (NSString *) name;
-(id) initWithName: (NSString *) name position:(PositionInTable) pos;
-(void) getChips;
-(NSArray *)getChipsFor:(int)i;

@end
