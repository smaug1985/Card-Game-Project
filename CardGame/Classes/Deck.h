//
//  Deck.h
//  cardGame
//
//  Created by gali on 27/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"


@interface Deck : NSObject {
	
	NSMutableArray *arrayCards;
}

@property (nonatomic,retain) NSMutableArray *arrayCards;


-(id) initWithPlist:(NSString *)plist;
-(id) initWithPlist:(NSString *)plist numDeck:(int) num;
-(void) shuffle;
-(Card *) pop;

@end
