//
//  OptionDeckLayer.m
//  CardGame
//
//  Created by Fran on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionDeckLayer.h"


@implementation OptionDeckLayer

-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		GameSettings *prefs = [GameSettings sharedSettings];
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//Algunas configuraciones de la vista
		int padding = 26;
		int titlePaddingTop = 25;
		int cardPaddingTop = 100;
		
		//Titulo de seccion
		CCLabel* title = [CCLabel labelWithString:NSLocalizedString (@"menu_change_baraja_title",@"menu_change_baraja_title") fontName:@"Royalacid_o" fontSize:40];
		title.position = ccp (s.width/2,s.height-(title.contentSize.height/2)-titlePaddingTop);
		[self addChild:title];
		
		NSString *path = [[NSBundle mainBundle] pathForResource:@"decks" ofType:@"plist"];
		//Array que contiene los nombres de todas las barajas
		NSArray *array = [NSArray arrayWithContentsOfFile:path];
		
		//Creo un menu que contendra el grid de las barajas
		CCMenu *cardMenu = [CCMenu menuWithItems:nil];
		
		//Variable contador
		int a =0;
		//Calculo el numero de filas
		double rounded = ceil([array count]/4.0);
		
		for (int i=0; i<rounded; i++) {
		
			for (int j=0; j<4;j++) {
				
				if (a<[array count]){
					
					//Creo la carta como item de menu y le asigno un selector
					carta = [MyMenuItemImage itemFromNormalImage:[array objectAtIndex:a] selectedImage:[array objectAtIndex:a] target:self selector:@selector(changeDeck:)];
					
					//Asigno el nombre de la imagen para poder rescatarla posteriormente
					carta.imageName= [array objectAtIndex:a];
					
					//Escalo las cartas a un tamaño apropiado para la pantalla
					[carta setScale:0.4];
					
					//Coloco el punto "Zero" en la esquina inferior izquierda de la carta
					[carta setAnchorPoint:ccp(0,0)];
					
					//Coloco la carta en la posicion que le corresponde
					carta.position =  ccp( ((carta.contentSize.width*carta.scale)*j)+padding*j, (s.height-(carta.contentSize.height*carta.scale)-cardPaddingTop)-((carta.contentSize.height*carta.scale)*i)-padding*i);
					
					//Añado la carta al menu
					[cardMenu addChild:carta];
					
					a++;
					
				}
				
			}
		
		}
		
		//Posiciono el menu en 0,0 para que las cartas tengan la posicion que les puse anteriormente
		cardMenu.position = ccp(0,0);
		//Añado el menu
		[self addChild:cardMenu];
		
		//Boton para volver al menu de opciones
		CCMenuItemImage *backItem = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrowOver.png" target:self selector:@selector(backOptionMenu)];
		
		CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
		backMenu.position = ccp(backItem.contentSize.width/2, backItem.contentSize.height/2);
		
		[self addChild:backMenu];
		
	}	
	return self;
}

- (void) changeDeck:(id)sender{

	GameSettings *prefs = [GameSettings sharedSettings];
	
	//NSLog(@"%@",sender);
	MyMenuItemImage *image = (MyMenuItemImage *) sender;
	//NSLog(@"deck selected: %@",image.imageName);
	[prefs setDeck:image.imageName];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"changeDeck" object:@""];

}

- (void) backOptionMenu{

	[[NSNotificationCenter defaultCenter] postNotificationName:@"backOptionMenu" object:@""];
	
}

@end
