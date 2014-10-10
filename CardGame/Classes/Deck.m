//
//  Deck.m
//  cardGame
//
//  Created by gali on 27/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Deck.h"


@implementation Deck
@synthesize arrayCards;

-(id) initWithPlist:(NSString *)plist numDeck:(int) n
{
	
	if( (self=[super init] )) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		self.arrayCards =array;
		[array release];
		
		NSString *filepath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
		NSMutableArray *cardsTmp = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
		NSDictionary *tmp = nil;//[[NSDictionary alloc] init];
		
		NSString *num = nil;//[[NSString alloc] init];
		NSString *palo = nil;//[[NSString alloc] init];
		NSString *image = nil;//[[NSString alloc] init];
		float valor;
		
		for (int i=0; i<n; i++) {
			for (int j =0; j<[cardsTmp count]; j++) {
			
				tmp = [NSDictionary dictionaryWithDictionary:[cardsTmp objectAtIndex:j]];
				
				num = [tmp objectForKey:@"num"];
				palo = [tmp objectForKey:@"palo"];
				image = [tmp objectForKey:@"sprite"];
				valor = [[tmp objectForKey:@"blackjackValue"] floatValue];
			
				Card *carta = [[Card alloc] initWithNum:num palo:palo valor:valor image:image estado:YES];
				[self.arrayCards addObject:carta];
				[carta release];
			}
		}
		
		[self shuffle];
		[cardsTmp release];
		
	}
	return self;	
	
}

-(id) initWithPlist:(NSString *)plist;
{
	if( (self=[super init] )) {
		NSMutableArray *array = [[NSMutableArray alloc] init];
		self.arrayCards =array;
		[array release];
		
		NSString *filepath = [[NSBundle mainBundle] pathForResource:plist ofType:@"plist"];
		NSMutableArray *cardsTmp = [[NSMutableArray alloc] initWithContentsOfFile:filepath];
		NSDictionary *tmp = nil;//[[NSDictionary alloc] init];
		
		NSString *num = nil;//[[NSString alloc] init];
		NSString *palo = nil;//[[NSString alloc] init];
		NSString *image = nil;//[[NSString alloc] init];
		float valor;
		
		
		for (int i =0; i<[cardsTmp count]; i++) {
			
			tmp = [NSDictionary dictionaryWithDictionary:[cardsTmp objectAtIndex:i]];
			
			num = [tmp objectForKey:@"num"];
			palo = [tmp objectForKey:@"palo"];
			image = [tmp objectForKey:@"sprite"];
			valor = [[tmp objectForKey:@"valor"] floatValue];
			
			Card *carta = [[Card alloc] initWithNum:num palo:palo valor:valor image:image estado:YES];
			[self.arrayCards addObject:carta];
			[carta release];

		}
		
		[self shuffle];
		[cardsTmp release];
		
	}
	return self;
}

-(void) shuffle
{
	NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self.arrayCards count]];
	
	NSMutableArray *copy = [self.arrayCards mutableCopy];
	
	while ([copy count] > 0)
	{
		int index = arc4random() % [copy count];
		id objectToMove = [copy objectAtIndex:index];
		[array addObject:objectToMove];
		[copy removeObjectAtIndex:index];
	}
	
	[copy release];
	
	self.arrayCards = array;
}

/*-(void) mostrarArray{

	for (int i=0; i<[self.arrayCards count]; i++) {
		Card *carta = [self.arrayCards objectAtIndex:i];
		NSLog(@"----  %@", carta.num);
		[carta release];
	}
}*/

-(Card *) pop
{
	@try {
		Card *carta = [[[self.arrayCards lastObject] retain]autorelease];
		[self.arrayCards removeLastObject];
		return carta;
	}
	@catch (NSException * e) {
		return nil;
	}
	
}


-(void)dealloc {
	[super dealloc];
	[arrayCards release];
}

@end
