//
//  BJPlayerLayer.h
//  CardGame
//
//  Created by gali on 06/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "PlayerBJ.h"

#define CHIPWIDTH 32
#define CHIPSCALE 0.6

@interface BJChipsLayer : CCLayer {
	
}

-(id) initWith:(PlayerBJ *) player;
- (void) drawChips:(PlayerBJ *)player;

@end
