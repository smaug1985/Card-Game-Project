//
//  CardDownLayer.h
//  CardGame
//
//  Created by gali on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Deck.h"

@interface CardDownLayer : CCLayer {

	Deck *deck;
	
}

@property (nonatomic, retain) Deck *deck;

- (void) cardDown;

@end
