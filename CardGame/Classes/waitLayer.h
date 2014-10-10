//
//  waitLayer.h
//  CardGame
//
//  Created by gali on 02/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlackJackOnlineLayer.h"

@interface waitLayer : CCLayer {

	CCMenu *menuWait;
	BlackJackOnlineLayer *layerBJ;
}


@property(nonatomic, retain) CCMenu *menuWait;
@property(nonatomic, retain) BlackJackOnlineLayer *layerBJ;


-(id) initWithMatch:(GKMatch *) aMatch isHost:(BOOL) host;

@end
