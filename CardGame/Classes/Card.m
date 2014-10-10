//
//  Card.m
//  cardGame
//
//  Created by gali on 27/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Card.h"


@implementation Card
@synthesize num, palo, valor, image, imageName, pos;



-(id) initWithNum:(NSString *)n palo:(NSString *)p valor:(float)v image:(NSString *)i estado:(BOOL)po
{
	if( (self=[super init] )) {
		
		GameSettings *prefs = [GameSettings sharedSettings];
		
		self.pos = po;
		self.num = n;
		self.palo = p;
		self.valor = v;
		self.imageName = [NSString stringWithFormat:@"%@.png",i];
		
		if (po == YES) {
			self.image = [[CCSprite alloc] initWithFile:self.imageName];
		}else {
			self.image = [[CCSprite alloc] initWithFile:prefs.deck];
		}
	}
	return self;
}

-(void) liberar{
	[self.image.parent removeChild:self.image cleanup:YES];
	[self.image stopAllActions];
	[self release];
}

-(void) cambiarEstado {
	GameSettings *prefs = [GameSettings sharedSettings];
	//NSLog(@"8========) %@",prefs.deck);
	if (self.pos == YES) {
		CCTexture2D *_tmp = [[CCTextureCache sharedTextureCache] addImage:prefs.deck];
		self.image.texture = _tmp;
		self.pos = NO;
	} else {
		CCTexture2D *_tmp = [[CCTextureCache sharedTextureCache] addImage:self.imageName];
		self.image.texture = _tmp;
		self.pos = YES;
	}
}

-(void)dealloc {
	[num release];
	[palo release];
	[image release];
	[imageName release];
	[super dealloc];
		
}

@end
