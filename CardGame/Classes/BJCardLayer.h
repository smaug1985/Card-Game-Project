//
//  BJCardLayer.h
//  CardGame
//
//  Created by gali on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerBJ.h"
#import "Card.h"

#define CARDSCALE 0.35

@protocol CardLayerEvents <NSObject>

-(void) animationCardMade;
-(void) removeCardMade;
-(void) stateChanged;

@end

@interface BJCardLayer : CCLayer {

	id<CardLayerEvents> delegate;
	PlayerBJ *playerBJ;
	
	Card *card;
	
}
@property (nonatomic,retain) id<CardLayerEvents> delegate;
@property (nonatomic,retain) PlayerBJ *playerBJ;
@property (nonatomic,retain) Card *card;

- (void) drawCards:(PlayerBJ *)player card:(Card *)c;
-(void) changeCardsFor:(PlayerBJ *)dealer withCallFunc:(BOOL) stateChanged;
- (void) changeCardState;
- (void) removeAllCardsFromTable;

@end
