//
//  OptionMenuLayer.m
//  CardGame
//
//  Created by Fran on 01/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "OptionMenuLayer.h"


@implementation OptionMenuLayer

@synthesize image;

- (id) init{

	if( (self=[super init] )) {
		
		GameSettings *prefs = [GameSettings sharedSettings];
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		//Algunas configuraciones de la vista
		int titlePaddingTop = 20;
		int paddingSide = 20;
		int optionsPaddingTop = 120;
		
		//Titulo de seccion
		CCLabel* title = [CCLabel labelWithString:NSLocalizedString (@"settings",@"settings") fontName:@"Royalacid_o" fontSize:40];
		title.position = ccp (s.width/2,s.height-(title.contentSize.height/2)-titlePaddingTop);
		[self addChild:title];
		
		//OPCION SONIDO
		
		//Titulo opcion sonido
		CCLabel *soundLabel = [CCLabel labelWithString:NSLocalizedString (@"menu_sound",@"menu_sound") fontName:@"Royalacid" fontSize:30];
		soundLabel.position = ccp(paddingSide,s.height-optionsPaddingTop);
		[soundLabel setAnchorPoint:ccp(0,0)];
		[self addChild:soundLabel];
		
		//Opcion sonido
		CCLabel *soundLabelValue1 = [CCLabel labelWithString:NSLocalizedString (@"menu_sound_op1",@"menu_sound_op1") fontName:@"Royalacid" fontSize:30];
		CCLabel *soundLabelValue2 = [CCLabel labelWithString:NSLocalizedString (@"menu_sound_op2",@"menu_sound_op2") fontName:@"Royalacid" fontSize:30];
		
		CCMenuItemToggle *soundOption = [CCMenuItemToggle 
								   itemWithTarget:self 
								   selector:@selector(changeSoundOption) 
								   items:[CCMenuItemFont itemWithLabel:soundLabelValue1 target:self selector:@selector(changeSoundOption)],
										 [CCMenuItemFont itemWithLabel:soundLabelValue2 target:self selector:@selector(changeSoundOption)],
										  nil];
		[soundOption setAnchorPoint:ccp(0,0)];
		soundOption.position = ccp(s.width-(soundOption.contentSize.width+paddingSide),s.height-optionsPaddingTop);
		
		if (prefs.sound) {
			soundOption.selectedIndex = 0;
		}else {
			soundOption.selectedIndex = 1;
		}

		
		//OPCION BARAJA
		
		//Titulo opcion baraja
		CCLabel *deckLabel = [CCLabel labelWithString:NSLocalizedString (@"menu_baraja",@"menu_baraja") fontName:@"Royalacid" fontSize:30];
		deckLabel.position = ccp(paddingSide,s.height-optionsPaddingTop*2);
		[deckLabel setAnchorPoint:ccp(0,0)];
		[self addChild:deckLabel];
		
		//Opcion baraja
		self.image = [NSString stringWithString:prefs.deck];
		
		CCMenuItemImage *deckOption = [CCMenuItemImage itemFromNormalImage:image selectedImage:image target:self selector:@selector(changeDeckOption)];
		
		[deckOption setScale:0.3];
		[deckOption setAnchorPoint:ccp(0,0)];
		deckOption.position = ccp(s.width-(soundOption.contentSize.width+paddingSide),s.height-optionsPaddingTop*2);
		
		//MENU OPCIONES
		
		//Creo el menu que contiene los botones de las opciones
		CCMenu *opciones = [CCMenu menuWithItems:soundOption,deckOption,nil];
		
		//Coloco el menu en 0,0 para que los botones adopten la posicion que les indiqué
		opciones.position = ccp(0,0);
		//[opciones alignItemsInColumns: [NSNumber numberWithUnsignedInt:1],[NSNumber numberWithUnsignedInt:1],nil ];
		
		//Añado el menu al layer
		[self addChild:opciones];
		
		//Creo el boton volver
		CCMenuItemLabel *backItem = [CCMenuItemImage itemFromNormalImage:@"backArrow.png" selectedImage:@"backArrowOver.png" target:self selector:@selector(backMainMenu)];
		//Lo añado a su menú correspondiente
		CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
		//Posiciono el menú
		backMenu.position = ccp(backItem.contentSize.width/2, backItem.contentSize.height/2);
		//Añado el menú al layer
		[self addChild:backMenu];
		
	}
	
	return self;

}

- (void) changeDeckOption{
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"deck" object:@""];
	
}

- (void) changeSoundOption{

	[[NSNotificationCenter defaultCenter] postNotificationName:@"sound" object:@""];
	
}

- (void) backMainMenu{

	[[NSNotificationCenter defaultCenter] postNotificationName:@"backMenuFromLeft" object:@""];
	
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	
	[image release];
	
	[super dealloc];
}


@end
