//
//  MyMenuItemImage.h
//  CardGame
//
//  Created by Fran on 04/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MyMenuItemImage : CCMenuItemImage {
	NSString *imageName;
}

@property (retain,nonatomic) NSString *imageName;
@end
