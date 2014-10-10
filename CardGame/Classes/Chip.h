//
//  Chip.h
//  CardGame
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Chip : CCSprite {
	int value;
}
@property (nonatomic,assign) int value;

-(id) initWithFile:(NSString *) filename value:(int)val;
@end
