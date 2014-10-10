//
//  Chip.m
//  CardGame
//
//  Created by Borja Rubio Soler on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Chip.h"


@implementation Chip

@synthesize value;

-(id) initWithFile:(NSString *) filename value:(int)val{
	self = [super initWithFile:filename];
	if( (self = [super initWithFile:filename]) ){
		self.value = val;
	}
	return self;
}

@end
