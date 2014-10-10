//
//  BJDescription.m
//  CardGame
//
//  Created by Borja Rubio Soler on 18/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BJDescription.h"


@implementation BJDescription



-(id) init
{
	
	if( (self=[super init])) {
		
		// ask director the the window size
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		NSString *text = NSLocalizedString (@"description",@"description");
		// DESCRIPCION DEL JUEGO
		CGSize textSize = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:17.0f]
						   constrainedToSize:CGSizeMake(self.contentSize.width-10, CGFLOAT_MAX)
							   lineBreakMode:UILineBreakModeWordWrap];
		
		//CCLabel *description = [CCLabel labelWithString:text fontName:@"Royalacid_o" fontSize:22];
		description = [CCLabel labelWithString:text dimensions:textSize alignment:UITextAlignmentLeft fontName:@"Royalacid" fontSize:17];
		description.anchorPoint = ccp(0,1);
		description.position =  ccp(0 ,s.height-100 );
		[self addChild:description];
		
		self.contentSize = CGSizeMake(self.contentSize.width, 400);
	self.isTouchEnabled = YES;
					
	}
	return self;
}
CGPoint startPoint;
-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event{
	
		CGPoint point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
	CGPoint movedPoint = [[CCDirector sharedDirector] convertToGL:point];
	int result = movedPoint.y-startPoint.y;
	description.position = ccp(description.position.x,description.position.y+result);
	NSLog(@"x=%d y=%d",description.position.x,description.position.y);
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
	NSLog(@"Pressed on layer!!");
	CGPoint point = [touch locationInView:[[CCDirector sharedDirector] openGLView]];
	startPoint = [[CCDirector sharedDirector] convertToGL:point];
	
	return YES;
}

@end
