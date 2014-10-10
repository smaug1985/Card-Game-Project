//
//  BlackjackDescriptionLayer.h
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "BJSettingsLayer.h"

@interface GameDescriptionLayer : CCLayer {

	BJSettingsLayer *bjConfLayer;
	UITextView *des;
	
}

@property (nonatomic, retain) UITextView *des;

@end
