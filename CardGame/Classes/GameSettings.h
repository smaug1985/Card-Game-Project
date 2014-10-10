//
//  Settings.h
//  CardGame
//
//  Created by Fran on 02/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameSettings : NSObject {

	BOOL sound;
	NSString *deck;
	
}

@property (nonatomic, assign) BOOL sound;
@property (nonatomic, retain) NSString *deck;

+ (id) sharedSettings;
- (void) saveSettings;

@end
