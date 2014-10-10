//
//  HelloWorldLayer.h
//  ExampleCocos2D
//
//  Created by gali on 25/06/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorld Layer
@interface GameListLayer : CCLayer
{
	CCMenu *menu;
	CCSprite *background;
}

// returns a Scene that contains the HelloWorld as the only child

//-(void) disableMenu:(BOOL) disabled;

@property (nonatomic, retain) CCMenu *menu;
@property (nonatomic, retain) CCSprite *background;
@end
