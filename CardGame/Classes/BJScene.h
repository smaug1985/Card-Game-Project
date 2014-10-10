//
//  GameScene.h
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BlackjackLayer.h"
#import "BlackJackOnlineLayer.h"
#import "waitLayer.h"

@interface BJScene :CCScene 
{

}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
+(id) sceneWithMatch:(GKMatch *) aMatch isHost:(BOOL) host;

@end
