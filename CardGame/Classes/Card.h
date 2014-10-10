//
//  Card.h
//  cardGame
//
//  Created by gali on 27/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameSettings.h"

@interface Card : NSObject {
	
	NSString *num;
	NSString *palo;
	float valor;
	NSString *imageName;
	CCSprite *image;
	BOOL pos;
	
}
@property (nonatomic,retain) NSString *num;
@property (nonatomic,retain) NSString *palo;
@property (nonatomic,assign) float valor;
@property (nonatomic,retain) CCSprite *image;
@property (nonatomic,retain) NSString *imageName;
@property (nonatomic,assign) BOOL pos;



-(id) initWithNum:(NSString *)n palo:(NSString *)p valor:(float)v image:(NSString *)i estado:(BOOL)po;
-(void) cambiarEstado;
-(void) liberar;
@end
