//
//  Settings.m
//  CardGame
//
//  Created by Fran on 02/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameSettings.h"


@implementation GameSettings

@synthesize sound;

- (id) init{

	self = [super init];
	
	//Obtengo las preferencias
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath: path]){
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
		
		[fileManager copyItemAtPath:bundle toPath:path error:&error];
		path= bundle;
		//[bundle release];
	}
	NSMutableDictionary *dictmp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	
	//Asigno los valores a las propiedades correspondientes de la clase
	self.sound = [[dictmp objectForKey:@"sound"] boolValue];
	self.deck = [NSString stringWithString:[dictmp objectForKey:@"deck"]];
	
	//Libero el diccionario temporal
	[dictmp release];

	return self;
	
}

static GameSettings *settings = nil;

+ (id) sharedSettings{

	if (settings == nil){
		settings = [[self alloc] init];
	}
	return settings;

}

- (void) saveSettings{

	//Obtengo las preferencias
	NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
	NSMutableDictionary *dictmp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	
	NSLog(@"Musica %@\n", (self.sound ? @"YES" : @"NO"));
	NSLog(@"Baraja %@\n", self.deck);
	
	[dictmp setValue:[NSNumber numberWithBool:self.sound] forKey:@"sound"];
	[dictmp setValue:self.deck forKey:@"deck"];
	
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *path2 = [documentsDirectory stringByAppendingPathComponent:@"settings.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath: path2]){
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
		
		[fileManager copyItemAtPath:bundle toPath:path2 error:&error];
		[bundle release];
	}
	[dictmp writeToFile:path2 atomically:YES];

}

- (void) setDeck:(NSString *)d{

	[deck release];
	deck = [d retain];

}

- (NSString *) deck{

	if (deck == nil) {
		NSString *path = [[NSBundle mainBundle] pathForResource:@"settings" ofType:@"plist"];
		NSMutableDictionary *dictmp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
		
		deck = [[dictmp objectForKey:@"deck"] retain];
	}
	return deck;
	
}

- (void) dealloc{

	[deck release];
	[super dealloc];
	
}

@end
