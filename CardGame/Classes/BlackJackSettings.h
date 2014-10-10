//
//  BlackJackSettings.h
//  optionsBJ
//
//  Created by Acquamedia on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlackJackSettings : NSObject {

	BOOL opFall;
	BOOL opDouble;
	BOOL opSplit;
	int opDeck;
	int opTable;
}

@property (nonatomic,assign) BOOL opFall;
@property (nonatomic,assign) BOOL opDouble;
@property (nonatomic,assign) BOOL opSplit;
@property (nonatomic,assign) int opDeck;
@property (nonatomic,assign) int opTable;

+ (id) sharedSettings;
- (void) saveSettings;
@end
