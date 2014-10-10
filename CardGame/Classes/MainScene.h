//
//  HelloWorldLayer.h
//  CardGame
//
//  Created by Fran on 28/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Deck.h"
#import "MainMenuLayer.h"
#import "GameListLayer.h"
#import "CardDownLayer.h"


#define ANIMATION_DURATION 0.3

// HelloWorld Layer
@interface MainScene :CCScene
{
	
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
+(void) replaceLayer:(CCLayer *)layer stopAnimation:(BOOL)b withAnimation:(NSString *)animation;

//animation methods
+(void) animationToLeft:(CCLayer *)layer;
+(void) animationToRight:(CCLayer *)layer;
+(void) animationToTop:(CCLayer *)layer;
+(void) animationToBottom:(CCLayer *)layer;
+(void) animationFlip360:(CCLayer *)layer;
+(void) animationJumpZoom:(CCLayer *)layer;
+(void) animationRotoZoom:(CCLayer *)layer;
+(void) animationShrinkGrow:(CCLayer *)layer;
+(void) animationFlipX:(CCLayer *)layer;
+(void) animationFlipY:(CCLayer *)layer;
+(void) animationFlipAngular:(CCLayer *)layer;
+(void) animationZoomFlipX:(CCLayer *)layer;
+(void) animationZoomFlipY:(CCLayer *)layer;
+(void) animationZoomFlipAngular:(CCLayer *)layer;
+(void) animationPageTurn:(CCLayer *)layer;
+(void) animationFadeTR:(CCLayer *)layer;
+(void) animationMoveZoomToLeft:(CCLayer *)layer;
+(void) animationMoveZoomToRight:(CCLayer *)layer;
+(void) animationMoveZoomToTop:(CCLayer *)layer;
+(void) animationMoveZoomToBottom:(CCLayer *)layer;
+(void) animationRotateToLeft:(CCLayer *)layer;

//animar layer
+(void) fadeInLayer;
+(void) fadeOutLayer;

@end