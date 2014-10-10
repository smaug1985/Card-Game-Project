//
//  HelloWorldLayer.m
//  CardGame
//
//  Created by Fran on 28/09/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

// Import the interfaces
#import "MainScene.h"

// HelloWorld implementation
@implementation MainScene

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// Añado fondo de escena
	CCSprite *back = [[CCSprite alloc] initWithFile:@"table.png"];
	[back setAnchorPoint:CGPointMake(0, 0)];
	[scene addChild:back z:0 tag:0];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer z:1 tag:1];
	
	CardDownLayer *cardLayer = [[CardDownLayer alloc] init];
	[scene addChild:cardLayer z:99 tag:99];
	
	// return the scene
	return scene;
}



+(void) replaceLayer:(CCLayer *)layer stopAnimation:(BOOL)b withAnimation:(NSString *)animation {
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	
	[scene addChild:layer z:1 tag:2];
	
	if ([animation isEqual:@"left"]) {
		
		[self animationToLeft:layer];
		
	} else if ([animation isEqual:@"right"]) {
		
		[self animationToRight:layer];
		
	} else if ([animation isEqual:@"top"]) {
		
		[self animationToTop:layer];
		
	} else if ([animation isEqual:@"bottom"]) {
		
		[self animationToBottom:layer];
		
	} else if ([animation isEqual:@"flip360"]) {
		
		[self animationFlip360:layer];
		
	}else if ([animation isEqual:@"JumpZoom"]) {
		
		[self animationJumpZoom:layer];
		
	}else if ([animation isEqual:@"RotoZoom"]) {
		
		[self animationRotoZoom:layer];
		
	}else if ([animation isEqual:@"ShrinkGrow"]) {
		
		[self animationShrinkGrow:layer];
		
	}else if ([animation isEqual:@"FlipX"]) {
		
		[self animationFlipX:layer];
		
	}else if ([animation isEqual:@"FlipY"]) {
		
		[self animationFlipY:layer];
		
	}else if ([animation isEqual:@"FlipAngular"]) {
		
		[self animationFlipAngular:layer];
		
	}else if ([animation isEqual:@"ZoomFlipX"]) {
		
		[self animationZoomFlipX:layer];
		
	}else if ([animation isEqual:@"ZoomFlipY"]) {
		
		[self animationZoomFlipY:layer];
		
	}else if ([animation isEqual:@"ZoomFlipAngular"]) {
		
		[self animationZoomFlipAngular:layer];
		
	}else if ([animation isEqual:@"PageTurn"]) {
		
		[self animationPageTurn:layer];
		
	}else if ([animation isEqual:@"FadeTR"]) {
		
		[self animationFadeTR:layer];
		
	}else if ([animation isEqual:@"MoveZoomToLeft"]) {
		
		[self animationMoveZoomToLeft:layer];
		
	}else if ([animation isEqual:@"MoveZoomToRight"]) {
		
		[self animationMoveZoomToRight:layer];
		
	}else if ([animation isEqual:@"MoveZoomToTop"]) {
		
		[self animationMoveZoomToTop:layer];
		
	}else if ([animation isEqual:@"MoveZoomToBottom"]) {
		
		[self animationMoveZoomToBottom:layer];
		
	}else if ([animation isEqual:@"RotateToLeft"]) {
		
		[self animationRotateToLeft:layer];
		
	}
	
	
	[scene getChildByTag:2].tag = 1;
	
	if (b == YES) {
		[scene removeChildByTag:99 cleanup:YES];
	}
	
}

+ (void) removeLayer{
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	
	[scene removeChildByTag:1 cleanup:YES];
	
}

+(void) fadeOutLayer {
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	//CCNode *layerActual = [scene getChildByTag:1];
	CCAction *action = [CCFadeOut actionWithDuration:0.01];
	
	[scene runAction:action];
}

+(void) fadeInLayer {
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	//CCNode *layerActual = [scene getChildByTag:1];
	CCAction *action = [CCFadeIn actionWithDuration:0.01];
	
	[scene runAction:action];
}

//Animaciones

+ (void) animationToLeft:(CCLayer *)layer{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	layer.position = ccp(s.width,0);
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(-s.width, 0)];
	
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layerActual runAction:seq];
}

+ (void) animationToRight:(CCLayer *)layer{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	layer.position = ccp(-s.width,0);
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(s.width, 0)];
	
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layerActual runAction:seq];
	
}

+ (void) animationToTop:(CCLayer *)layer{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	layer.position = ccp(0,-s.height);
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, s.height)];
	
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layerActual runAction:seq];
	
}

+ (void) animationToBottom:(CCLayer *)layer{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	layer.position = ccp(0,s.height);
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, -s.height)];
	
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layerActual runAction:seq];
	
}

+(void) animationMoveZoomToLeft:(CCLayer *)layer
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.75f];
	[layer setPosition:ccp( s.width,0 )];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *jump = [CCMoveBy actionWithDuration:0.3 position:ccp(-s.width,0)];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:0.3 scale:1.0f];
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:0.3 scale:0.75f];
	
	//CCIntervalAction *jumpZoomOut = [CCSequence actions: scaleOut, jump, nil];
	//CCIntervalAction *jumpZoomIn = [CCSequence actions: jump, scaleIn, nil];
	
	CCIntervalAction *delay = [CCDelayTime actionWithDuration:0.6];
	
	//[layerActual runAction: jumpZoomOut];
	[layerActual runAction:jump];
	[layerActual runAction:scaleOut];
	/*[layer runAction: [CCSequence actions: delay,
					   jumpZoomIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];*/
	[layer runAction: [CCSequence actions: delay,
					   jump,
					   nil] ];
	[layer runAction: [CCSequence actions: delay,
					   scaleIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];
}

+(void) animationMoveZoomToRight:(CCLayer *)layer
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.75f];
	[layer setPosition:ccp( -s.width,0 )];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *jump = [CCMoveBy actionWithDuration:0.3 position:ccp(s.width,0)];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:0.3 scale:1.0f];
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:0.3 scale:0.75f];
	
	//CCIntervalAction *jumpZoomOut = [CCSequence actions: scaleOut, jump, nil];
	//CCIntervalAction *jumpZoomIn = [CCSequence actions: jump, scaleIn, nil];
	
	CCIntervalAction *delay = [CCDelayTime actionWithDuration:0.6];
	
	//[layerActual runAction: jumpZoomOut];
	[layerActual runAction: jump];
	[layerActual runAction: scaleOut];
	/*[layer runAction: [CCSequence actions: delay,
					   jumpZoomIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];*/
	[layer runAction: [CCSequence actions: delay,
					   jump,
					   nil] ];
	[layer runAction: [CCSequence actions: delay,
					   scaleIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];
}

+(void) animationMoveZoomToTop:(CCLayer *)layer
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.75f];
	[layer setPosition:ccp( 0,-s.height )];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *jump = [CCMoveBy actionWithDuration:0.3 position:ccp(0,s.height)];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:0.3 scale:1.0f];
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:0.3 scale:0.75f];
	
	CCIntervalAction *jumpZoomOut = [CCSequence actions: scaleOut, jump, nil];
	CCIntervalAction *jumpZoomIn = [CCSequence actions: jump, scaleIn, nil];
	
	CCIntervalAction *delay = [CCDelayTime actionWithDuration:0.6];
	
	[layerActual runAction: jumpZoomOut];
	[layer runAction: [CCSequence actions: delay,
					   jumpZoomIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];
}
+(void) animationMoveZoomToBottom:(CCLayer *)layer
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.75f];
	[layer setPosition:ccp( 0,s.height )];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *jump = [CCMoveBy actionWithDuration:0.3 position:ccp(0,-s.height)];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:0.3 scale:1.0f];
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:0.3 scale:0.75f];
	
	CCIntervalAction *jumpZoomOut = [CCSequence actions: scaleOut, jump, nil];
	CCIntervalAction *jumpZoomIn = [CCSequence actions: jump, scaleIn, nil];
	
	CCIntervalAction *delay = [CCDelayTime actionWithDuration:0.6];
	
	[layerActual runAction: jumpZoomOut];
	[layer runAction: [CCSequence actions: delay,
					   jumpZoomIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];
}

+ (void) animationFlip360:(CCLayer *)layer
{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	layer.position = ccp(s.width,0);
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(-s.width, 0)];
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layerActual runAction:seq];
	
	
	CCOrbitCamera *orbit = [CCOrbitCamera actionWithDuration:2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:360 angleX:0 deltaAngleX:90];
	CCSequence *seq2 = [CCSequence actions: [CCDelayTime actionWithDuration:ANIMATION_DURATION],
						orbit,
						nil];
	[scene runAction: seq2];
	
}


+(void) animationJumpZoom:(CCLayer *)layer
{
	CGSize s = [[CCDirector sharedDirector] winSize];
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.5f];
	[layer setPosition:ccp( s.width,0 )];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *jump = [CCJumpBy actionWithDuration:4/4 position:ccp(-s.width,0) height:s.width/4 jumps:2];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:4/4 scale:1.0f];
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:4/4 scale:0.5f];
	
	CCIntervalAction *jumpZoomOut = [CCSequence actions: scaleOut, jump, nil];
	CCIntervalAction *jumpZoomIn = [CCSequence actions: jump, scaleIn, nil];
	
	CCIntervalAction *delay = [CCDelayTime actionWithDuration:4/2];
	
	[layerActual runAction: jumpZoomOut];
	[layer runAction: [CCSequence actions: delay,
					   jumpZoomIn,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil] ];
}


+(void) animationRotoZoom:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.001f];
	[layerActual setScale:1.0f];
	
	[layer setAnchorPoint:ccp(0.5f, 0.5f)];
	[layerActual setAnchorPoint:ccp(0.5f, 0.5f)];
	
	CCIntervalAction *rotozoom = [CCSequence actions: [CCSpawn actions:
													   [CCScaleBy actionWithDuration:4/2 scale:0.001f],
													   [CCRotateBy actionWithDuration:4/2 angle:360 *2],
													   nil],
								  [CCDelayTime actionWithDuration:4/2],
								  nil];
	
	
	[layerActual runAction: rotozoom];
	[layer runAction: [CCSequence actions:
					   [rotozoom reverse],
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil]];
}



+(void) animationShrinkGrow:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	[layer setScale:0.001f];
	[layerActual setScale:1.0f];
	
	[layer setAnchorPoint:ccp(2/3.0f,0.5f)];
	[layerActual setAnchorPoint:ccp(1/3.0f,0.5f)];	
	
	CCIntervalAction *scaleOut = [CCScaleTo actionWithDuration:4 scale:0.01f];
	CCIntervalAction *scaleIn = [CCScaleTo actionWithDuration:4 scale:1.0f];
	
	[layer runAction: [CCEaseOut actionWithAction:scaleIn rate:2.0f]];
	[layerActual runAction: [CCSequence actions:
							 [CCEaseOut actionWithAction:scaleOut rate:2.0f],
							 [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
							 nil] ];
}

+(void) animationFlipX:(CCLayer *)layer
{
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	//if( orientation == kOrientationRightOver ) {
	inDeltaZ = 90;
	inAngleZ = 270;
	outDeltaZ = 90;
	outAngleZ = 0;
	/*} else {
	 inDeltaZ = -90;
	 inAngleZ = 90;
	 outDeltaZ = -90;
	 outAngleZ = 0;
	 }*/
	
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:4/2],
		   [CCShow action],
		   [CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:0 deltaAngleX:0],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:0 deltaAngleX:0],
			[CCHide action],
			[CCDelayTime actionWithDuration:4/2],							
			nil ];
	
	[layer runAction: inA];
	[layerActual runAction: outA];
	
}

+(void) animationFlipY:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	/*if( orientation == kOrientationUpOver ) {
	 inDeltaZ = 90;
	 inAngleZ = 270;
	 outDeltaZ = 90;
	 outAngleZ = 0;
	 } else {*/
	inDeltaZ = -90;
	inAngleZ = 90;
	outDeltaZ = -90;
	outAngleZ = 0;
	//}
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:4/2],
		   [CCShow action],
		   [CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:90 deltaAngleX:0],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:90 deltaAngleX:0],
			[CCHide action],
			[CCDelayTime actionWithDuration:4/2],							
			nil ];
	
	[layer runAction: inA];
	[layerActual runAction: outA];
	
}


+(void) animationFlipAngular:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	//if( orientation == kOrientationRightOver ) {
	inDeltaZ = 90;
	inAngleZ = 270;
	outDeltaZ = 90;
	outAngleZ = 0;
	/*} else {
	 inDeltaZ = -90;
	 inAngleZ = 90;
	 outDeltaZ = -90;
	 outAngleZ = 0;
	 }*/
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:4/2],
		   [CCShow action],
		   [CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:-45 deltaAngleX:0],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:45 deltaAngleX:0],
			[CCHide action],
			[CCDelayTime actionWithDuration:4/2],							
			nil ];
	
	[layer runAction: inA];
	[layerActual runAction: outA];
}

+(void) animationZoomFlipX:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	//if( orientation == kOrientationRightOver ) {
	inDeltaZ = 90;
	inAngleZ = 270;
	outDeltaZ = 90;
	outAngleZ = 0;
	/*} else {
	 inDeltaZ = -90;
	 inAngleZ = 90;
	 outDeltaZ = -90;
	 outAngleZ = 0;
	 }*/
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:4/2],
		   [CCSpawn actions:
			[CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:0 deltaAngleX:0],
			[CCScaleTo actionWithDuration:4/2 scale:1],
			[CCShow action],
			nil],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCSpawn actions:
			 [CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:0 deltaAngleX:0],
			 [CCScaleTo actionWithDuration:4/2 scale:0.5f],
			 nil],
			[CCHide action],
			[CCDelayTime actionWithDuration:4/2],							
			nil ];
	
	layer.scale = 0.5f;
	[layer runAction: inA];
	[layerActual runAction: outA];
}


+(void) animationZoomFlipY:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	/*if( orientation == kOrientationUpOver ) {
	 inDeltaZ = 90;
	 inAngleZ = 270;
	 outDeltaZ = 90;
	 outAngleZ = 0;
	 } else {*/
	inDeltaZ = -90;
	inAngleZ = 90;
	outDeltaZ = -90;
	outAngleZ = 0;
	//}
	
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:4/2],
		   [CCSpawn actions:
			[CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:90 deltaAngleX:0],
			[CCScaleTo actionWithDuration:4/2 scale:1],
			[CCShow action],
			nil],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCSpawn actions:
			 [CCOrbitCamera actionWithDuration: 4/2 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:90 deltaAngleX:0],
			 [CCScaleTo actionWithDuration:4/2 scale:0.5f],
			 nil],							
			[CCHide action],
			[CCDelayTime actionWithDuration:4/2],							
			nil ];
	
	layer.scale = 0.5f;
	[layer runAction: inA];
	[layerActual runAction: outA];
}


+(void) animationZoomFlipAngular:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCIntervalAction *inA, *outA;
	[layer setVisible: NO];
	
	float inDeltaZ, inAngleZ;
	float outDeltaZ, outAngleZ;
	
	//if( orientation == kOrientationRightOver ) {
	inDeltaZ = 90;
	inAngleZ = 270;
	outDeltaZ = 90;
	outAngleZ = 0;
	/*} else {
	 inDeltaZ = -90;
	 inAngleZ = 90;
	 outDeltaZ = -90;
	 outAngleZ = 0;
	 }*/
	
	inA = [CCSequence actions:
		   [CCDelayTime actionWithDuration:1],
		   [CCSpawn actions:
			[CCOrbitCamera actionWithDuration: 1 radius: 1 deltaRadius:0 angleZ:inAngleZ deltaAngleZ:inDeltaZ angleX:-45 deltaAngleX:0],
			[CCScaleTo actionWithDuration:1 scale:1],
			[CCShow action],
			nil],						   
		   [CCShow action],
		   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
		   nil ];
	outA = [CCSequence actions:
			[CCSpawn actions:
			 [CCOrbitCamera actionWithDuration: 1 radius: 1 deltaRadius:0 angleZ:outAngleZ deltaAngleZ:outDeltaZ angleX:45 deltaAngleX:0],
			 [CCScaleTo actionWithDuration:1 scale:0.5f],
			 nil],							
			[CCHide action],
			[CCDelayTime actionWithDuration:1],							
			nil ];
	
	layer.scale = 0.5f;
	[layer runAction: inA];
	[layerActual runAction: outA];
}

+(void) animationPageTurn:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	int x,y;
	if( s.width > s.height)
	{
		x=16;y=12;
	}
	else
	{
		x=12;y=16;
	}
	
	id action  = [CCReverseTime actionWithAction:[CCPageTurn3D actionWithSize:ccg(x,y) duration:4]];
	
	layer.visible = NO;
	[layer runAction: [CCSequence actions:[CCShow action],action,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   [CCStopGrid action],
					   nil]];
}

+(void) animationFadeTR:(CCLayer *)layer
{
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	//layer.visible = NO;
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	float aspect = s.width / s.height;
	int x = 12 * aspect;
	int y = 12;
	
	id action  =[CCFadeOutTRTiles actionWithSize:ccg(x,y) duration:2];
	
	[layerActual runAction: [CCSequence actions:
							 action,
							 [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
							 [CCStopGrid action],
							 nil]];
}

+(void) animationRotateToLeft:(CCLayer *)layer{
	CGSize s = [[CCDirector sharedDirector] winSize];
	// layer.position = ccp(s.width,0);
	layer.position = ccp(layer.contentSize.height+s.width,-layer.contentSize.height);
	layer.rotation = 90.0;
	
	CCScene *scene = [[CCDirector sharedDirector] runningScene];
	CCNode *layerActual = [scene getChildByTag:1];
	
	CCAction *action1 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(0, 0)];
	// CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(-s.width, 0)];
	CCAction *action2 = [CCMoveTo actionWithDuration:ANIMATION_DURATION position:ccp(-s.height, -s.width)];
	CCAction *action3 = [CCRotateTo actionWithDuration:ANIMATION_DURATION angle:0.0];
	CCAction *action4 = [CCRotateTo actionWithDuration:ANIMATION_DURATION angle:-90.0];
	CCSequence *seq = [CCSequence actions: action2,
					   [CCCallFunc actionWithTarget:self selector:@selector(removeLayer)],
					   nil];
	
	[layer runAction:action1];
	[layer runAction:action3];
	[layerActual runAction:action4];
	[layerActual runAction:seq];
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
