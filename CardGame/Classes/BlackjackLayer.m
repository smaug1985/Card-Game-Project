//
//  BlackjackLayer.m
//  CardGame
//
//  Created by gali on 05/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BlackjackLayer.h"


@implementation BlackjackLayer
@synthesize blackjack, modalMenu, chipsLayer, chipsBetLayer, cardLayer, pauseLayer,pauseButton,localPlayerScore;
@synthesize myMatch, allChannel;
@synthesize gc;

-(id) init
{
	
	if( (self=[super init])) {
		
		
		
		bjprefs = [BlackJackSettings sharedSettings];
		
		gc = [[GameCenter alloc] init];
		gc.delegate = self;
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		
		self.pauseLayer = [[PauseMenuLayer alloc] init];
		[self addChild:pauseLayer z:999999999];
		
		
		self.pauseLayer.delegate = self;
		//PAUSE MENU
		
		CCLabel *pauseLabel = [CCLabel labelWithString:@"Pause" fontName:@"Royalacid_o" fontSize:20];
		self.pauseButton = [CCMenuItemLabel itemWithLabel:pauseLabel target:self selector:@selector(pause)];
		
		//Añado los elementos al menu y añado el menu
		CCMenu *pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
		//Configuro el menu
		[pauseMenu setAnchorPoint:ccp(0,0)];
		pauseMenu.position = ccp(100,s.height-20);
		
		[self addChild:pauseMenu z:999999];
		
		//FIN PAUSE MENU
		
		
		self.localPlayerScore = 0;
		[gc retrieveLocalPlayerScore];
		
		
		NSMutableArray *arrayPlayers = [NSMutableArray arrayWithCapacity:4];
		
		int cnt=1;
		
		PlayerBJ *player1;
		PlayerBJ *player2;
		PlayerBJ *player3;
		PlayerBJ *player4;
		//Añado jugadores temporales
		while (cnt <= bjprefs.opTable) {
			
			switch (cnt) {
				case 1:
					if ([GKLocalPlayer localPlayer].authenticated) {
						NSLog(@"player is authenticated");
						player1 = [[PlayerBJ alloc] initWithName:[GKLocalPlayer localPlayer].alias position:PositionInTableMiddleLeft money:1000];
						
					}
					else {
						player1 = [[PlayerBJ alloc] initWithName:@"Player1" position:PositionInTableMiddleLeft money:1000];
					}

					
					[arrayPlayers addObject:player1];
					break;
					
				case 2:
					if ([GKLocalPlayer localPlayer].authenticated) {
						NSLog(@"player is authenticated");
						player2 = [[PlayerBJ alloc] initWithName:[GKLocalPlayer localPlayer].alias position:PositionInTableMiddleRight money:1000];
						
					}
					else {
						player2 = [[PlayerBJ alloc] initWithName:@"Player2" position:PositionInTableMiddleLeft money:1000];
					}
					
					
					[arrayPlayers addObject:player2];
					break;
					
				case 3:
					if ([GKLocalPlayer localPlayer].authenticated) {
						NSLog(@"player is authenticated");
						player3 = [[PlayerBJ alloc] initWithName:[GKLocalPlayer localPlayer].alias position:PositionInTableLeft money:1000];
						
					}
					else {
						player3 = [[PlayerBJ alloc] initWithName:@"Player3" position:PositionInTableMiddleLeft money:1000];
					}
					
					
					[arrayPlayers addObject:player3];
					break;
					
				case 4:
					if ([GKLocalPlayer localPlayer].authenticated) {
						NSLog(@"player is authenticated");
						player4 = [[PlayerBJ alloc] initWithName:[GKLocalPlayer localPlayer].alias position:PositionInTableRight money:1000];
						
					}
					else {
						player4 = [[PlayerBJ alloc] initWithName:@"Player4" position:PositionInTableMiddleLeft money:1000];
					}
					
					
					[arrayPlayers addObject:player4];
					break;
					
				default:
					break;
			}
			
			cnt++;
			
		}
		
		Deck *decktmp = [[Deck alloc] initWithPlist:@"frenchDeck" numDeck:bjprefs.opDeck];
		
		self.blackjack = [[Blackjack alloc] initWithDeck:decktmp listOfPlayers:arrayPlayers];
		
		[decktmp release];
		
		cnt=1;
		//Elimino jugadores temporales
		while (cnt <= bjprefs.opTable) {
			
			switch (cnt) {
				case 1:
					[player1 release];
					break;
					
				case 2:
					[player2 release];
					break;
					
				case 3:
					[player3 release];
					break;
					
				case 4:
					[player4 release];
					break;
					
				default:
					break;
			}
			
			cnt++;
			
		}
		
		self.blackjack.delegate = self;
		
		
		//Pinto nombre de jugadores
		[self drawPlayerNames];
		
		//Pinto el dinero de los jugadores
		[self drawPlayerMoney];
		
		//Pinto al Dealer
		[self drawDealer];
		
		//Pintar las fichas de cada jugador
		for (int i=0; i < [self.blackjack.players count]; i++) {
			PlayerBJ *p = [self.blackjack.players objectAtIndex:i];
			
			self.chipsLayer = [[BJChipsLayer alloc] initWith:p];
			[self addChild:chipsLayer z:9999 tag:p.position];
		}
		
		//Pintar las fichas apostadas de cada jugador
		for (int i=0; i < [self.blackjack.players count]; i++) {
			PlayerBJ *p = [self.blackjack.players objectAtIndex:i];
			
			self.chipsBetLayer = [[BJChipsBetLayer alloc] initWith:p];
			[self addChild:self.chipsBetLayer z:88 tag:100+p.position];
		}
		
		//Modal menu
		self.modalMenu = [[ModalMenuLayer alloc] init];
		self.modalMenu.delegate = self;
		[self addChild:self.modalMenu z:9999999];
		
		//Menu de apuesta del primer jugador
		[self.modalMenu showModalMenuWith:BetMenu playerBJ:[self.blackjack.players objectAtIndex:0]];
		
		//inicializar layer cartas
		self.cardLayer = [[BJCardLayer alloc] init];
		self.cardLayer.delegate = self;
		[self addChild:cardLayer z:99];
		
	}
	return self;
	
}


-(id) initWithMatch:(GKMatch *) aMatch{
	
	if( (self=[super init])) {
		bjprefs = [BlackJackSettings sharedSettings];
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		
		self.pauseLayer = [[PauseMenuLayer alloc] init];
		[self addChild:pauseLayer z:999999999];
		
		
		self.pauseLayer.delegate = self;
		//PAUSE MENU
		
		CCLabel *pauseLabel = [CCLabel labelWithString:@"Pause" fontName:@"Royalacid_o" fontSize:20];
		self.pauseButton = [CCMenuItemLabel itemWithLabel:pauseLabel target:self selector:@selector(pause)];
		
		//Añado los elementos al menu y añado el menu
		CCMenu *pauseMenu = [CCMenu menuWithItems:pauseButton, nil];
		//Configuro el menu
		[pauseMenu setAnchorPoint:ccp(0,0)];
		pauseMenu.position = ccp(100,s.height-20);
		
		[self addChild:pauseMenu z:999999];
		allChannel = nil;
		PlayerBJ *localPlayer = [[PlayerBJ alloc] initWithName:[[GKLocalPlayer localPlayer] alias] position:PositionInTableRight money:2000];
		
		
		Deck *decktmp = [[Deck alloc] initWithPlist:@"frenchDeck" numDeck:2];
		self.blackjack = [[Blackjack alloc] initWithDeck:decktmp];
		self.blackjack.players = [[NSMutableArray alloc] init];
		[blackjack.players addObject:localPlayer];
		[decktmp release];
		self.myMatch = aMatch;
		myMatch.delegate = self;
		self.blackjack.delegate = self;
		
		[self drawDealer];
		NSLog(@"number of players:: %d", [[aMatch playerIDs] count]);
		
		
		
		//configuring audio session
		
		NSError *myErr = nil;
		AVAudioSession *audioSession = [AVAudioSession sharedInstance];
		
		[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&myErr];
		UInt32 doChangeDefaultRoute = 1;
		AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);
		if(myErr!=nil){
			NSLog(@"Meec!!! ERROR: %@",myErr);
		}
		[audioSession setActive: YES error: &myErr];
		if(myErr!=nil){
			NSLog(@"Meec!!! ERROR: %@",myErr);
		}
		
		
		/*************************************PRUEBA DE ENVIO DE MENSAJES*****************************/
	//	CGSize s = [[CCDirector sharedDirector] winSize];
		
		CCLabel *host = [CCLabel labelWithString:NSLocalizedString(@"SEND MESSAGE", @"SEND MESSAGE") fontName:@"Royalacid_o" fontSize:30];
		CCMenuItem *menuItemHost = [CCMenuItemFont itemWithLabel:host target:self selector:@selector(pruevaEnvio)];
		menuItemHost.position = ccp(s.width-menuItemHost.contentSize.width/2, menuItemHost.contentSize.height/2);
		
		CCMenu *footMenu = [CCMenu menuWithItems:menuItemHost,nil];
		//[footMenu alignItemsInRows:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1], nil];
		footMenu.position = ccp(s.width-footMenu.contentSize.width-10,0);
		
		[self addChild:footMenu];
		/*************************************PRUEBA DE ENVIO DE MENSAJES*****************************/
		
		
		//Modal menu
		self.modalMenu = [[ModalMenuLayer alloc] init];
		self.modalMenu.delegate = self;
		[self addChild:self.modalMenu z:9999999];
		//inicializar layer cartas
		self.cardLayer = [[BJCardLayer alloc] init];
		self.cardLayer.delegate = self;
		[self addChild:cardLayer z:99];
		
		
		
		
		
		
	}
	return self;
	
	
	
	
	
}


- (void) pause{
	
	[self.pauseButton setIsEnabled:NO];
	[self.pauseLayer showPauseMenu];
	
}

- (void) dealloc{

	[blackjack release];
	[modalMenu release];
	[chipsLayer release];
	[chipsBetLayer release];
	[cardLayer release];
	
	[gc release];
	
	[super dealloc];
	
}

-(int) getPuntuation:(PlayerBJ *)player{
	
	if (player.money > 1000) {
		return player.money-1000;
	}else {
		return 0;
	}
	
	
}

#pragma mark draw methods

- (void) drawDealer{

	//PINTANDO Al DEALER
	
	GameSettings *prefs = [GameSettings sharedSettings];
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	//Pinto la baraja
	CCSprite *deckSprite = [CCSprite spriteWithFile:@"deck.png"];
	[deckSprite setScale:0.35];
	deckSprite.anchorPoint = ccp(0.5,0.5);
	//deckSprite.rotation = 20.0;
	[self addChild:deckSprite];
	
	CCSprite *deckS = [CCSprite spriteWithFile:prefs.deck];
	[deckS setScale:0.35];
	deckS.anchorPoint = ccp(0.5,0.5);
	//deckS.rotation = 20.0;
	[self addChild:deckS];
	
	int diferencia = deckSprite.contentSize.height*deckSprite.scale-deckS.contentSize.height*deckS.scale;
	
	deckSprite.position = ccp(s.width/2+100, s.height - deckSprite.contentSize.height*deckSprite.scale+10);
	deckS.position = ccp(s.width/2+100, s.height - (deckSprite.contentSize.height*deckSprite.scale)+diferencia+10);
	
	//Torres de fichas
	//Ficha10
	CCSprite *chip10Tower = [CCSprite spriteWithFile:@"ficha10Torre1.png"];
	chip10Tower.scale = 0.6;
	int towerWidth = chip10Tower.contentSize.width*chip10Tower.scale;
	chip10Tower.position = ccp(s.width/2-towerWidth*2, s.height - chip10Tower.contentSize.height/2);
	
	[self addChild:chip10Tower];
	
	//Ficha25
	CCSprite *chip25Tower = [CCSprite spriteWithFile:@"ficha25Torre1.png"];
	chip25Tower.scale = 0.6;
	chip25Tower.position = ccp(s.width/2-towerWidth, s.height - chip25Tower.contentSize.height/2);
	
	[self addChild:chip25Tower];
	
	//Ficha100
	CCSprite *chip100Tower = [CCSprite spriteWithFile:@"ficha100Torre1.png"];
	chip100Tower.scale = 0.6;
	chip100Tower.position = ccp(s.width/2, s.height - chip100Tower.contentSize.height/2);
	
	[self addChild:chip100Tower];
	
	//Ficha200
	CCSprite *chip200Tower = [CCSprite spriteWithFile:@"ficha200Torre1.png"];
	chip200Tower.scale = 0.6;
	chip200Tower.position = ccp(s.width/2+towerWidth, s.height - chip200Tower.contentSize.height/2);
	
	[self addChild:chip200Tower];
	
	//Ficha500
	CCSprite *chip500Tower = [CCSprite spriteWithFile:@"ficha500Torre1.png"];
	chip500Tower.scale = 0.6;
	chip500Tower.position = ccp(s.width/2+towerWidth*2, s.height - chip500Tower.contentSize.height/2);
	
	[self addChild:chip500Tower];
	//Fin torre de fichas

}

- (void) drawPlayerNames {
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	int marginBottom = 110;
	float cuarto = s.width/4;
	CGPoint point;	
	
	
	for (int i=0; i<[self.blackjack.players count]; i++) {
		
		PlayerBJ *player = [self.blackjack.players objectAtIndex:i];
		
		switch (player.position) {
				
			case PositionInTableLeft:
				
				point = CGPointMake(cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableMiddleLeft:
				
				point = CGPointMake(cuarto+cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableMiddleRight:
				
				point = CGPointMake(cuarto*3-cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableRight:
				
				point = CGPointMake(cuarto*4-cuarto/2, marginBottom);
				
				break;
			default:
				break;
		}
		
		CCLabel *pName = [CCLabel labelWithString:player.playerName fontName:@"Royalacid_o" fontSize:20];
		pName.anchorPoint = ccp(0.5,0.5);
		pName.position = ccp(point.x,point.y);
		[self addChild:pName];
		
	}
	
}

- (void) drawPlayerMoney {
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	int marginBottom = 90;
	float cuarto = s.width/4;
	CGPoint point;	
	
	
	for (int i=0; i<[self.blackjack.players count]; i++) {
		
		PlayerBJ *player = [self.blackjack.players objectAtIndex:i];
		
		switch (player.position) {
				
			case PositionInTableLeft:
				
				point = CGPointMake(cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableMiddleLeft:
				
				point = CGPointMake(cuarto+cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableMiddleRight:
				
				point = CGPointMake(cuarto*3-cuarto/2, marginBottom);
				
				break;
				
			case PositionInTableRight:
				
				point = CGPointMake(cuarto*4-cuarto/2, marginBottom);
				
				break;
			default:
				break;
		}
		
		CCLabel *pMoney = [CCLabel labelWithString:[NSString stringWithFormat:@"%d",player.money] fontName:@"Royalacid_o" fontSize:20];
		pMoney.anchorPoint = ccp(0.5,0.5);
		pMoney.position = ccp(point.x,point.y);
		[self addChild:pMoney z:0 tag:200+player.position];
		
	}
	
}


- (void) drawChips{
	
	for (PlayerBJ* p in blackjack.players) {
		
		
		self.chipsLayer = [[BJChipsLayer alloc] initWith:p];
		[self addChild:chipsLayer z:9999 tag:p.position];
	}
	
	
}

- (void) drawBet{
	for (PlayerBJ* p in blackjack.players) {
		
		
		self.chipsBetLayer = [[BJChipsBetLayer alloc] initWith:p];
		[self addChild:self.chipsBetLayer z:88 tag:100+p.position];
	}
	
}

-(void) updatePlayerMoneyLabels:(PlayerBJ *)player{

	CCLabel *l = [self getChildByTag:200+player.position];
	[l setString:[NSString stringWithFormat:@"%d",player.money]];

}

-(void) drawCards {
	
	int numCards = 0;
	
	while (numCards < 2) {
	
		//repartir 1 carta a cada jugador
		for (int i=0; i < [self.blackjack.players count]; i++) {
			[self.blackjack giveCard:1 to:[self.blackjack.players objectAtIndex:i] toHand:PlayerHandFirst];
		}
		
		//repartir 1 carta a el diler
		[self.blackjack giveCard:1 to:self.blackjack.dealer toHand:PlayerHandFirst];
		
		numCards++;
		
	}

}

- (void) dealerAction{

	while ([self.blackjack.dealer playerHandPuntuation:PlayerHandFirst] < 17) {
		
		if ([self.blackjack.dealer playerHandPuntuation:PlayerHandFirst] != -1) {
			
			[self.blackjack giveCard:1 to:self.blackjack.dealer];
			
		}
		else {
			break;
		}

		//[self.cardLayer runAction:[CCDelayTime actionWithDuration:0.5]];
		
	}
	
	[self updatePlayerStatus];
	
	//[self.cardLayer runAction:[CCDelayTime actionWithDuration:5.0]];
	
	 PlayerBJ *player;
	 BJChipsBetLayer *bjChipsBet;
	 PlayerResult r;
	 
	 for (int i=0; i < [self.blackjack.players count]; i++) {
	 
		 player = [self.blackjack.players objectAtIndex:i];
		 
		 r = [self.blackjack comparePlayerWithDealer:player];
		 
		 bjChipsBet = [self getChildByTag:100+player.position];
		 
		 [bjChipsBet drawChips:player withResult:r];
	 
	 }
	
	[self.blackjack comparePlayerWithDealerAndDealMoney:[self.blackjack.players objectAtIndex:0]];
	
	PlayerBJ *p = [self.blackjack.players objectAtIndex:0];
	self.chipsLayer = [self getChildByTag:p.position];
	[p getChips];
	[self.chipsLayer drawChips:p];
	
	 //Menu con resultado
	 r = [self.blackjack comparePlayerWithDealer:[self.blackjack.players objectAtIndex:0]];
	 [self.modalMenu showCompareMenu:[self.blackjack.players objectAtIndex:0] dealer:self.blackjack.dealer result:r];
	 //[self.modalMenu showCompareMenu:[self.blackjack.players objectAtIndex:0] dealer:self.blackjack.dealer];
	 //[self.modalMenu showModalMenuWith:CompareMenu playerBJ:[self.blackjack.players objectAtIndex:0]];

}

-(void) checkPlayerStatus:(PlayerBJ *)p
{   
	
	int index = [self.blackjack.players indexOfObject:p];
    int controlador=0;
    PlayerBJ *player = p;
    if (player.position == PositionInTableMiddleLeft && controlador ==0) {
        if ([self.blackjack.players count] > 1 || index != [self.blackjack.players count]-1) {
			player = [self getNextPlayerByPlayer:p];
            //player = [self.blackjack.players objectAtIndex:1];
            controlador = 1;
			
            if (player.status == PlayerHasBlackjack) {
                //BJ
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerHas21) {
                //21
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerUnderPuntuation) {
                [self.modalMenu showModalMenuWith:ActionMenu playerBJ:player];
            }
            else if (player.status == PlayerBusted) {
                //BT
                //Mostrar Mensaje de Perdedor
				
                controlador = 0;
            }
        }else {
			[cardLayer changeCardsFor:self.blackjack.dealer withCallFunc:YES];
			//[self dealerAction];
		}

    }
	
	
	
	
	
    if (player.position == PositionInTableMiddleRight && controlador ==0) {
        if ([self.blackjack.players count] > 2 || index != [self.blackjack.players count]-1) {
			player = [self getNextPlayerByPlayer:p];
            //player = [self.blackjack.players objectAtIndex:2];
            controlador = 1;
			
            if (player.status == PlayerHasBlackjack) {
                //BJ
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerHas21) {
                //21
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerUnderPuntuation) {
                [self.modalMenu showModalMenuWith:ActionMenu playerBJ:player];
            }
            else if (player.status == PlayerBusted) {
                //BT
                //Mostrar Mensaje de Perdedor
				
                controlador = 0;
            }
			
        }else {
			[cardLayer changeCardsFor:self.blackjack.dealer withCallFunc:YES];
			//[self dealerAction];
		}

    }
	

	
	
	
    if (player.position == PositionInTableLeft && controlador ==0) {
        if ([self.blackjack.players count] > 3 || index != [self.blackjack.players count]-1) {
			player = [self getNextPlayerByPlayer:p];
            //player = [self.blackjack.players objectAtIndex:3];
            controlador = 1;
			
            if (player.status == PlayerHasBlackjack) {
                //BJ
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
				
				
            }
            else if (player.status == PlayerHas21) {
                //21
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
				
            }
            else if (player.status == PlayerUnderPuntuation) {
                [self.modalMenu showModalMenuWith:ActionMenu playerBJ:player];
            }
            else if (player.status == PlayerBusted) {
                //BT
                //Mostrar Mensaje de Perdedor
				
                controlador = 0;
				
            }
        }else {
			[cardLayer changeCardsFor:self.blackjack.dealer withCallFunc:YES];
			//[self dealerAction];
		}

    }
	
    if (player.position == PositionInTableRight && controlador ==0) {
        [cardLayer changeCardsFor:self.blackjack.dealer withCallFunc:YES];
		//[self dealerAction];
    }
}

-(void) updatePlayerStatus{

	PlayerBJ *player;
	for (int i=0; i<[self.blackjack.players count]; i++) {
		player = [self.blackjack.players objectAtIndex:i];
		player.status = [self.blackjack checkPlayerHand:player];
	}
	
	self.blackjack.dealer.status = [self.blackjack checkPlayerHand:self.blackjack.dealer];
	
}

-(void) restartGame {
	
	//Reinicio al dealer
	[self.blackjack.dealer cleanHand:PlayerHandFirst];
	[self.blackjack.dealer cleanHand:PlayerHandSecond];
	self.blackjack.dealer.bet = 0;
	for (int i=0; i<[self.blackjack.players count]; i++) {
		[self.blackjack cleanPlayer:[self.blackjack.players objectAtIndex:i]];
	}
	
	//Si tengo menos de 20 cartas, vuelvo a crear las barajas
	if ([self.blackjack.deck.arrayCards count] < 20) {
		Deck *decktmp = [[Deck alloc] initWithPlist:@"frenchDeck" numDeck:bjprefs.opDeck];
		
		self.blackjack.deck = decktmp;
		
		[decktmp release];
	}
	
	for (int i=0; i < [self.blackjack.players count]; i++) {
		[self playerLosed:[self.blackjack.players objectAtIndex:i]];
	}
	
	//Quito las cartas de la mesa
	[self.cardLayer removeAllCardsFromTable];
	
}

- (void) playerLosed:(PlayerBJ *)player{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	float cuarto = s.width/4;
	CGPoint point;
	
	switch (player.position) {
			
		case PositionInTableLeft:
			
			point = CGPointMake(cuarto/2, -10);
			
			break;
			
		case PositionInTableMiddleLeft:
			
			point = CGPointMake(cuarto+cuarto/2, -10);
			
			break;
			
		case PositionInTableMiddleRight:
			
			point = CGPointMake(cuarto*2+cuarto/2, -10);
			
			break;
			
		case PositionInTableRight:
			
			point = CGPointMake(s.width-cuarto/2, -10);
			
			break;
		default:
			break;
	}
	
	if (player.money < 10) {
		
		CCSprite *sprite = [CCSprite spriteWithFile:@"banned.png"];
		
		sprite.anchorPoint = ccp(0.5,0);
		sprite.position = ccp(point.x, point.y);
		[self addChild:sprite];
		
		[self.blackjack removePlayer:player];
		
	}
	
}

#pragma mark BlackjackEvents Protocol

-(void) deckIsVoid:(id) bj{

	Deck *decktmp = [[Deck alloc] initWithPlist:@"frenchDeck" numDeck:bjprefs.opDeck];
	
	self.blackjack.deck = decktmp;
	
	[decktmp release];

}

-(void) playerIsReady:(PlayerBJ *) player blackjack:(id)bj{}

-(void) playerBetted:(PlayerBJ *)player blackjack:(id)bj{

	BJChipsLayer *cl = [self getChildByTag:player.position];
	BJChipsBetLayer *cbl = [self getChildByTag:100+player.position];
	[cl drawChips:player];
	[cbl drawChipsBet:player];
	
	if (player == [self.blackjack.players lastObject] && [player.playerHand count] == 0) {
		NSLog(@"Ya hemos finalizado de apostar");
		[self drawCards];
	}
	
}

-(void) playerGotCard:(Card *)card toPlayer:(PlayerBJ *)player blackjack:(id)bj message:(BOOL)message{

	[self.cardLayer drawCards:player card:card];
	
}

-(void) playerSplited:(PlayerBJ *)player blackjack:(id)bj{}

//- (void) player:(PlayerBJ *)player withResult:(PlayerResult)result blackjack:(id)bj{}

#pragma mark ModalMenuEvents Protocol

-(void) compareWithDealerMade:(PlayerBJ *)p{
	
	int index = [self.blackjack.players indexOfObject:p];
	
	PlayerBJ *player;
	switch (p.position) {
			
		case PositionInTableMiddleLeft:
			
			if ([self.blackjack.players count] > 1 || index != [self.blackjack.players count]-1) {
				//Segundo jugador
				//player = [self.blackjack.players objectAtIndex:1];
				player = [self getNextPlayerByPlayer:p];
				
				PlayerResult r = [self.blackjack comparePlayerWithDealer:player];
				[self.blackjack comparePlayerWithDealerAndDealMoney:player];
				
				self.chipsLayer = [self getChildByTag:player.position];
				[player getChips];
				[self.chipsLayer drawChips:player];
				
				[self.modalMenu showCompareMenu:player dealer:self.blackjack.dealer result:r];
				
			}else {
				[self restartGame];
			}
			
			
			break;
			
		case PositionInTableMiddleRight:
			
			if ([self.blackjack.players count] > 2 || index != [self.blackjack.players count]-1) {
				//Tercer jugador
				//player = [self.blackjack.players objectAtIndex:2];
				player = [self getNextPlayerByPlayer:p];
				PlayerResult r = [self.blackjack comparePlayerWithDealer:player];
				[self.blackjack comparePlayerWithDealerAndDealMoney:player];
				
				self.chipsLayer = [self getChildByTag:player.position];
				[player getChips];
				[self.chipsLayer drawChips:player];
				
				[self.modalMenu showCompareMenu:player dealer:self.blackjack.dealer result:r];
				
			}else {
				[self restartGame];
			}
			
			
			break;
			
		case PositionInTableLeft:
			
			if ([self.blackjack.players count] > 3 || index != [self.blackjack.players count]-1) {
				//Cuarto jugador
				//player = [self.blackjack.players objectAtIndex:3];
				player = [self getNextPlayerByPlayer:p];
				PlayerResult r = [self.blackjack comparePlayerWithDealer:player];
				[self.blackjack comparePlayerWithDealerAndDealMoney:player];
				
				self.chipsLayer = [self getChildByTag:player.position];
				[player getChips];
				[self.chipsLayer drawChips:player];
				
				[self.modalMenu showCompareMenu:player dealer:self.blackjack.dealer result:r];
				
			}else {
				[self restartGame];
			}
			
			
			break;
			
		case PositionInTableRight:
			
			[self restartGame];
			
			break;
			
		default:
			break;
	}
	
	[self updatePlayerMoneyLabels:p];
	
}


-(PlayerBJ *) getNextPlayerByPlayer:(PlayerBJ *)p{
	
	int index = [self.blackjack.players indexOfObject:p];
	
	for (int i =index; i<3; i++) {
		index++;
		
		if ([blackjack.players objectAtIndex:index]) {
			return [blackjack.players objectAtIndex:index];
		}
	}
	
	
}


-(void) betMade:(int)bet byPlayer:(PlayerBJ *)p{
	
	//Hacer apuesta del primer jugador
	[self.blackjack addBet:bet player:p];
	
	int index = [self.blackjack.players indexOfObject:p];
	//NSLog(@"Index has %d", index);
	
	PlayerBJ *player;
	switch (p.position) {
			
		case PositionInTableMiddleLeft:
			
			if ([self.blackjack.players count] > 1 || index != [self.blackjack.players count]-1) {
				//Segundo jugador
				player = [self getNextPlayerByPlayer:p];
				[self.modalMenu showModalMenuWith:BetMenu playerBJ:player];
			
			}
			
			break;
			
		case PositionInTableMiddleRight:
			if ([self.blackjack.players count] > 2 || index != [self.blackjack.players count]-1) {
				//Tercer jugador
				player = [self getNextPlayerByPlayer:p];
				[self.modalMenu showModalMenuWith:BetMenu playerBJ:player];
				
			}
			
			break;
			
		case PositionInTableLeft:
			
			if ([self.blackjack.players count] > 3 || index != [self.blackjack.players count]-1) {
				//Cuarto jugador
				player = [self getNextPlayerByPlayer:p];
				[self.modalMenu showModalMenuWith:BetMenu playerBJ:player];
				
			}
			
			break;
			
		case PositionInTableRight:
			
			
			
			break;
			
		default:
			break;
	}
	
	[self updatePlayerMoneyLabels:p];
	
}

-(void) menuIsHide:(bool)status{

	menuIsHide = status;
	
}

-(void) cardButtonPushedBy:(PlayerBJ *)p{
	[self updatePlayerStatus];
	if(p.status == PlayerUnderPuntuation){
		
		PlayerBJ *player;
		switch (p.position) {
				
			case PositionInTableMiddleLeft:
				player = [blackjack getPlayerAtPosition:PositionInTableMiddleLeft];
				//player = [self.blackjack.players objectAtIndex:0];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableMiddleRight:
				player = [blackjack getPlayerAtPosition:PositionInTableMiddleRight];
				//player = [self.blackjack.players objectAtIndex:1];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableLeft:
				player = [blackjack getPlayerAtPosition:PositionInTableLeft];
				//player = [self.blackjack.players objectAtIndex:2];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableRight:
				player = [blackjack getPlayerAtPosition:PositionInTableRight];
				//player = [self.blackjack.players objectAtIndex:3];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			default:
				break;
		}
		
	}

}

-(void) continueButtonPushedBy:(PlayerBJ *)p{

	[self updatePlayerStatus];
	[self checkPlayerStatus:p];

}

- (void) doubleBetButtonPushedBy:(PlayerBJ *)p{

	if (p.money >= p.bet && [p.playerHand count] < 3) {
		
		[self updatePlayerStatus];
		if(p.status == PlayerUnderPuntuation){
			
			PlayerBJ *player;
			switch (p.position) {
					
				case PositionInTableMiddleLeft:
					player = [blackjack getPlayerAtPosition:PositionInTableMiddleLeft];
					//player = [self.blackjack.players objectAtIndex:0];
					[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
					[self.blackjack addBet:p.bet player:p];
					
					[self.modalMenu hideActionMenu];
					
					break;
					
				case PositionInTableMiddleRight:
					player = [blackjack getPlayerAtPosition:PositionInTableMiddleRight];
					//player = [self.blackjack.players objectAtIndex:1];
					[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
					[self.blackjack addBet:p.bet player:p];
					
					[self.modalMenu hideActionMenu];
					
					break;
					
				case PositionInTableLeft:
					player = [blackjack getPlayerAtPosition:PositionInTableLeft];
					//player = [self.blackjack.players objectAtIndex:2];
					[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
					[self.blackjack addBet:p.bet player:p];
					
					[self.modalMenu hideActionMenu];
					
					break;
					
				case PositionInTableRight:
					player = [blackjack getPlayerAtPosition:PositionInTableRight];
					//player = [self.blackjack.players objectAtIndex:3];
					[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
					[self.blackjack addBet:p.bet player:p];
					
					[self.modalMenu hideActionMenu];
					
					break;
					
				default:
					break;
			}
			
		}
		
	}
	
	[self updatePlayerMoneyLabels:p];

}

#pragma mark CardLayerEvents Protocol

-(void) animationCardMade{

	NSLog(@"Ya hemos terminado de repartir");
	
	[self updatePlayerStatus];	
	
	int controlador = 0;
	int count = [self.blackjack.players count];
	int i=0;
	
	PlayerBJ *player;
	
	//Muestro el menu de accion para el primer jugador que no tenga blackjack
	//Si jugador1 tiene blackjack y hay mas de 1 jugador...
	while (i<count && controlador ==0) {
        
            player = [self.blackjack.players objectAtIndex:i];

            if (player.status == PlayerHasBlackjack) {
                //BJ
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerHas21) {
                //21
                //Mostrar Mensaje de Ganador
				
                controlador = 0;
            }
            else if (player.status == PlayerUnderPuntuation) {
                [self.modalMenu showModalMenuWith:ActionMenu playerBJ:player];
				controlador=1;
            }
            else if (player.status == PlayerBusted) {
                //BT
                //Mostrar Mensaje de Perdedor
				
                controlador = 0;
            }
		
		i++;
		
		if (i == count && controlador == 0) {
			
			[cardLayer changeCardsFor:self.blackjack.dealer withCallFunc:YES];
			//[self dealerAction];
			
		}
		
    }

}

-(void) removeCardMade{

	//Menu de apuesta del primer jugador
	[self.modalMenu showModalMenuWith:BetMenu playerBJ:[self.blackjack.players objectAtIndex:0]];
	
}

- (void) stateChanged{

	[self dealerAction];

}

#pragma mark PauseMenuEvents Protocol


-(void) resumePause{
	
	[self.pauseButton setIsEnabled:YES];
	
}
-(void) exitPause{
	int money=0;
	//NSString *str = [NSString stringWithString:@"TMB"];
	for (int i=0; i<[self.blackjack.players count]; i++) {
		PlayerBJ *player = [self.blackjack.players objectAtIndex:i];
		money=money+[self getPuntuation:player];
	}
	
	int64_t allMoney = money;
	NSString *str = [NSString stringWithString:@"TMB2"];
	[self reportScore:allMoney forCategory:str];
	
	[[CCDirector sharedDirector] setDeviceOrientation:kCCDeviceOrientationPortrait];
	[[CCDirector sharedDirector] replaceScene:[CCFadeTransition transitionWithDuration:0.5 scene:[MainScene scene]]];
}

#pragma mark Game center scores methods

- (void) GotScore:(int64_t)i{

	self.localPlayerScore = i;
}

- (void) reportScore: (int64_t) score forCategory: (NSString*) category

{
	//GKScore *scoreReporter = [GKScore alloc];
	//[scoreReporter initWithCategory:category];
    GKScore *scoreReporter = [[[GKScore alloc] initWithCategory:category] autorelease];
	
    scoreReporter.value = self.localPlayerScore+score;
	
    [scoreReporter reportScoreWithCompletionHandler:^(NSError *error) {
		
		if (error != nil)
			
		{
			NSLog(@"Score reporting failed with error:%@", [error localizedDescription]);
            // handle the reporting error
			
        }
		
    }];
	
}



#pragma mark multiplayer methods

- (void) loadPlayerData: (NSArray *) identifiers

{
	
    [GKPlayer loadPlayersForIdentifiers:identifiers withCompletionHandler:^(NSArray *players, NSError *error) {
		PlayerBJ *playertmp;
		
		
        if (error != nil)
			
		{
			NSLog(@"Error loading players data: %@", error);
			// Handle the error.
			
		}
		
		if (players != nil)
			
		{
			for (GKPlayer* player in players) {
				NSLog(@"player alias:%@",[player alias]);
				//pos+=3;
				playertmp = [[PlayerBJ alloc] initWithName:[player alias] position:PositionInTableMiddleRight money:2000];
				playertmp.playerID = player.playerID;
				
				[self.blackjack.players addObject:playertmp];
			}
			// Process the array of GKPlayer objects.
			
			[self drawBet];
			[self drawCards];
			[self drawChips];
			[self drawPlayerNames];
			
			[self startVoiceChat];
			
			
		}
		
		
		
	}];
	
}
- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state

{
	NSLog(@"did change state:%@", playerID);
    switch (state)
	
    {
			
        case GKPlayerStateConnected:
			//[self sendTest:@"mensajitoo"];
			
			NSLog(@"player connected");
			//[blackjack.players ]
			//[self pruevaEnvio];
			//[self sendTest:@"me recibes?"];
			//laodplayerdata asigna el array de players desde game center
			
			
			//empezar partida
			
			
			break;
			
        case GKPlayerStateDisconnected:
			NSLog(@"player disconnected");
			
			//borrar jugador del array de players
			for (PlayerBJ *p in blackjack.players) {
				if ([p.playerID isEqualToString:playerID]) {
					[blackjack.players removeObject:p];
					
				}
			}
			
			//eliminar el layer del jugador desconectado
			/*
			for (CCNode *node in self.children) {
				if ([node isKindOfClass:[BJPlayerLayer class]]) {
					BJPlayerLayer * playerLayer = (BJPlayerLayer *)node;
					if ([playerLayer.player.playerID isEqualToString:playerID]) {
						[self removeChild:playerLayer cleanup:YES];
					}
				}
				
			}
			*/
			
			
			
            // a player just disconnected.
			
			break;
			
    }
	
    if (match.expectedPlayerCount == 0)
		
    {
		
        
		NSLog(@"NUMBER OF PLAYERS, %d, STARTING INITIAL MATCH NEGOTIATION", [match.playerIDs count]);
		[self loadPlayerData: match.playerIDs];
        // handle initial match negotiation.
		
    }
	
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID

{
	Packet incoming;
    if ([data length] == sizeof(Packet)) {
        [data getBytes:&incoming length:sizeof(Packet)];
		
	}
	
	
	// Packet *p = (Packet*)[data bytes];
	//int bet = p
	
	
	NSLog(@"message received:player %@ betted an amount of %d and has a puntuation of ",playerID, incoming.bet, incoming.puntuation);
	
	
	// handle a position message.
	
	
	
	
	
	/*NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	 
	 
	 
	 if (!arrayOfPlayers){
	 arrayOfPlayers = [[NSMutableArray alloc] init];
	 }
	 [arrayOfPlayers addObject:str];
	 
	 [str release];
	 */
	
	
}
- (void) cancelFindingProgramaticMatch
{
	[[GKMatchmaker sharedMatchmaker] cancel];
	NSLog(@"Finding match process stopped%@",@".");
	
}

- (void) disconnect{
	[myMatch disconnect];
	
}





-(void) pruevaEnvio
{
	//[self sendPacketofType:PacketTypeStart];
	
}
#pragma mark voice chat methods

- (void) startVoiceChat{
#if !(TARGET_IPHONE_SIMULATOR)
	// We are running on a device
	if (!allChannel) {
		allChannel = [myMatch voiceChatWithName:@"allPlayers"];
		
		allChannel.active = YES;
		allChannel.volume = 1;
		allChannel.playerStateUpdateHandler = ^(NSString *playerID, GKVoiceChatPlayerState state) {
			
			switch (state)
			
			{
					
				case GKVoiceChatPlayerSpeaking:
					NSLog(@"player speaking");
					// insert code to highlight the player.
					
					break;
					
				case GKVoiceChatPlayerSilent:
					NSLog(@"player silent");
					// insert code to dim the player.
					
					break;
					
			}
			
		};
	}
	[allChannel start];
#else
	
	
	NSLog(@"not starting voice chat, i am running in simulator");
	
	
	
#endif
	
	
	
	
	
	
	
	
	
	
	
}


-(void) stopVoiceChat
{
	[allChannel stop];
	
}


-(void) mutePlayer:(NSString *) inPlayerID
{
	for (PlayerBJ *p in blackjack.players) {
		if ([p.playerID isEqualToString:inPlayerID]) {
			if (!p.isMuted) {
				[allChannel setMute: YES forPlayer: inPlayerID];
			}
			else {
				[allChannel setMute: NO forPlayer: inPlayerID];
			}
			
		}
	}
	
	
}


@end
