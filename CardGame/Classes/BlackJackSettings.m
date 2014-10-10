//
//  BlackJackSettings.m
//  optionsBJ
//
//  Created by Acquamedia on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BlackJackSettings.h"


@implementation BlackJackSettings

@synthesize opFall, opDouble, opSplit,opDeck,opTable;

- (id) init{
	
	self = [super init];
	
	//Obtengo las preferencias
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"BlackJackSettings.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	if (![fileManager fileExistsAtPath: path]) //4
	{
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BlackJackSettings" ofType:@"plist"]; //5
		
		[fileManager copyItemAtPath:bundle toPath: path error:&error]; //6
	}
	NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
	//Asigno los valores a las propiedades correspondientes de la clase
	self.opFall = [[data objectForKey:@"fall"] boolValue];
	self.opDouble = [[data objectForKey:@"double"] boolValue];
	self.opSplit = [[data objectForKey:@"split"] boolValue];
	self.opDeck =[[data objectForKey:@"numDeck"] intValue];
	self.opTable =[[data objectForKey:@"numTable"] intValue];
	
	//Libero el diccionario temporal
	[data release];
	
	return self;
	
}

static BlackJackSettings *settings = nil;

+ (id) sharedSettings{
	
	settings = [[self alloc] init];
	
	return settings;
	
}

- (void) saveSettings{
	
	//Obtengo las preferencias
	NSError *error;
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	NSString *path = [documentsDirectory stringByAppendingPathComponent:@"BlackJackSettings.plist"];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	if (![fileManager fileExistsAtPath: path]){
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BlackJackSettings" ofType:@"plist"];
		
		[fileManager copyItemAtPath:bundle toPath:path error:&error];
		[bundle release];
	}
	
	NSMutableDictionary *dictmp = [[NSMutableDictionary alloc] initWithContentsOfFile:path];
	
	
	[dictmp setValue:[NSNumber numberWithBool: self.opFall] forKey:@"fall"];
	[dictmp setValue:[NSNumber numberWithBool: self.opDouble] forKey:@"double"];
	[dictmp setValue:[NSNumber numberWithBool: self.opSplit] forKey:@"split"];
	[dictmp setValue:[NSNumber numberWithInt:self.opDeck] forKey:@"numDeck"];
	[dictmp setValue:[NSNumber numberWithInt:self.opTable] forKey:@"numTable"];
	NSError *error2;
	NSArray *paths2 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
	NSString *documentsDirectory2 = [paths2 objectAtIndex:0]; 
	NSString *path2 = [documentsDirectory2 stringByAppendingPathComponent:@"BlackJackSettings.plist"];
	NSFileManager *fileManager2 = [NSFileManager defaultManager];
	NSLog(@"%@",path2);
	if (![fileManager2 fileExistsAtPath: path2]){
		NSString *bundle = [[NSBundle mainBundle] pathForResource:@"BlackJackSettings" ofType:@"plist"];
		
		[fileManager2 copyItemAtPath:bundle toPath:path2 error:&error2];
		[bundle release];
	}
	[dictmp writeToFile:path2 atomically:YES];
	
}


- (void) dealloc{

	[super dealloc];
	
}

@end
