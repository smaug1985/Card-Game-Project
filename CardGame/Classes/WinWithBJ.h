//
//  WinWithBJ.h
//  CardGame
//
//  Created by gali on 22/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface WinWithBJ : CCLayer {

	CCSprite *background;
	CCLabel *winBJ;
	
}

@property (nonatomic,retain) CCSprite *background;
@property (nonatomic,retain) CCLabel *winBJ;

-(void) showWinBJ;
-(void) hideWinBJ;

@end
