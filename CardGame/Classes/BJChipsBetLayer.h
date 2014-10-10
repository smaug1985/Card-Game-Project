//
//  BJChipsBetLayer.h
//  CardGame
//
//  Created by gali on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerBJ.h"

#define CHIPWIDTH 32
#define CHIPSCALE 0.6

@interface BJChipsBetLayer : CCLayer {

}
- (id) initWith:(PlayerBJ *) player;
- (void) drawChipsBet:(PlayerBJ *)player;

- (void) animationFromPlayerBetToDealer:(PlayerBJ *)player;
- (void) animationFromDealerToPlayerBet:(PlayerBJ *)player;
- (void) animationFromPlayerBetToPlayer:(PlayerBJ *)player;

- (void) drawChips:(PlayerBJ *)player withResult:(PlayerResult)result;

@end
