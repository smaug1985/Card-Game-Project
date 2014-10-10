//
//  BlackJackOnlineLayer.m
//  CardGame
//
//  Created by ender on 15/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BlackJackOnlineLayer.h"


@implementation BlackJackOnlineLayer
@synthesize blackjack, modalMenu, chipsLayer, chipsBetLayer, cardLayer, pauseLayer,pauseButton;
@synthesize myMatch, allChannel, isHost, localPlayerScore;
@synthesize  winWithBJ, gc;

-(id) init
{
	
	if( (self=[super init])) {
		
		
		
		bjprefs = [BlackJackSettings sharedSettings];
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		

		
		//blackjack menu
		
		winWithBJ = [[WinWithBJ alloc] init];
		[self addChild:winWithBJ z:9999999999];

		
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
	//NSString *str = [NSString stringWithString:@"TMB"];
	//[self reportScore:20 forCategory:str];
	return self;
	
}


-(id) initWithMatch:(GKMatch *) aMatch{
	
	if( (self=[super init])) {
		bjprefs = [BlackJackSettings sharedSettings];
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		localPlayerScore = 0;
		gc = [[GameCenter alloc] init];
		
		gc.delegate = self;
		[gc retrieveLocalPlayerScore];
		
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
		PlayerBJ *localPlayer = [[PlayerBJ alloc] initWithName:[[GKLocalPlayer localPlayer] alias] position:PositionInTableRight money:1000];
		localPlayer.playerID = [GKLocalPlayer localPlayer].playerID;
		
		localPlayer.playerHash = [localPlayer.playerID hash];
		
		
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
		
		
		
		
		
		//Modal menu
		self.modalMenu = [[ModalMenuLayer alloc] init];
		self.modalMenu.delegate = self;
		[self addChild:self.modalMenu z:9999999];
		//inicializar layer cartas
		self.cardLayer = [[BJCardLayer alloc] init];
		self.cardLayer.delegate = self;
		[self addChild:cardLayer z:99];
		//inicializar el menu modal de black jack
		self.winWithBJ = [[WinWithBJ alloc] init];
		[self addChild:winWithBJ];
		//Menu de apuesta del primer jugador
		[self.modalMenu showModalMenuWith:BetMenu playerBJ:[self.blackjack.players objectAtIndex:0]];
		
		
		
		
		
		
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
	
	[super dealloc];
	
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
		
		
		//altavoces
		CCSprite *soundPlayer = [CCSprite spriteWithFile:@"sound_high.png"];
		soundPlayer.anchorPoint = ccp(0.5,0.5);
		soundPlayer.position = ccp(point.x-35,point.y-19);
		soundPlayer.opacity = 0.0;
		[self addChild:soundPlayer z:99999 tag:player.position+666];
		
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
	
	if ([self localPlayer].isHost) {
		[self setAllPlayersNotReady];
		while ([self.blackjack.dealer playerHandPuntuation:PlayerHandFirst] < 17) {
			
			if ([self.blackjack.dealer playerHandPuntuation:PlayerHandFirst] != -1) {
				
				[self.blackjack giveCard:1 to:self.blackjack.dealer];
				
			}
			else {
				[self sendPacketofType:PacketTypeDealerDone];

				break;
			}
			
			
			//[self.cardLayer runAction:[CCDelayTime actionWithDuration:0.5]];
			
		}
		
		[self sendPacketofType:PacketTypeDealerDone];
	}
		PlayerBJ *player;
		BJChipsBetLayer *bjChipsBet;
	
		[self updatePlayerStatus];
		for (int i=0; i < [self.blackjack.players count]; i++) {
			
			player = [self.blackjack.players objectAtIndex:i];
			
			PlayerResult r;

			r = [self.blackjack comparePlayerWithDealer:player];
			bjChipsBet = [self getChildByTag:100+player.position];
			
			
			[self.blackjack comparePlayerWithDealerAndDealMoney:player];
			//if ([self localPlayer].isHost)
			//[self sendPacketofType:PacketTypeResult withResult:r withTarget:player.position];
			
		}
		
		[self afterDealer];
	
		
		
	
	
	
	
	
}

-(void) afterDealer{
	
	
	//[self.cardLayer runAction:[CCDelayTime actionWithDuration:5.0]];
	
	
	
	BJChipsBetLayer *bjChipsBet;

	
	
	PlayerBJ *p = [self localPlayer];
	PlayerResult r = [blackjack comparePlayerWithDealer:p];

	/*self.chipsLayer = [self getChildByTag:p.position];
	[p getChips];
	[self.chipsLayer drawChips:p];
	*/
	//Menu con resultado
	if ([self localPlayer]) {
		
			[self.modalMenu showCompareMenu:p dealer:self.blackjack.dealer result:r];

		

	}
	
	
	//[self.modalMenu showCompareMenu:[self.blackjack.players objectAtIndex:0] dealer:self.blackjack.dealer];
	//[self.modalMenu showModalMenuWith:CompareMenu playerBJ:[self.blackjack.players objectAtIndex:0]];
	
	for (PlayerBJ* p in blackjack.players) {
		r = [self.blackjack comparePlayerWithDealer:p];
		bjChipsBet = [self getChildByTag:100+p.position];
		[p getChips];
		[bjChipsBet drawChips:p withResult:r];
		[self updatePlayerMoneyLabels:p];
	}
}




-(void) checkPlayerStatus:(PlayerBJ *)p
{   
		if (p.status == PlayerHasBlackjack) {
			//BJ
			//Mostrar Mensaje de Ganador
			p.isReady = YES;
			if (p == [self localPlayer]) {
				[winWithBJ showWinBJ];
				if (!p.isHost) {
					[self sendPacketofType:PacketTypeStand];
				}
				else {
					[self continueButtonPushedBy:p];
				}
			 

			}
			
			

			
		}
		else if (p.status == PlayerHas21) {
			//21
			//Mostrar Mensaje de Ganador
			p.isReady = YES;
		}
		else if (p.status == PlayerUnderPuntuation) {
			[self.modalMenu showModalMenuWith:ActionMenu playerBJ:p];
		}
		else if (p.status == PlayerBusted) {
			//BT
			NSLog(@"Player :%@ is busted", p.playerName);
			p.isReady = YES;
		}
	

	
	
	
	/*
    int controlador=0;
    PlayerBJ *player = p;
    if (player.position == PositionInTableMiddleLeft && controlador ==0) {
        if ([self.blackjack.players count] > 1) {
            player = [self.blackjack.players objectAtIndex:1];
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
			[cardLayer changeCardsFor:self.blackjack.dealer];
			//[self dealerAction];
		}
		
    }
	
	
	
	
	
    if (player.position == PositionInTableMiddleRight && controlador ==0) {
        if ([self.blackjack.players count] > 2) {
            player = [self.blackjack.players objectAtIndex:2];
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
			[cardLayer changeCardsFor:self.blackjack.dealer];
			//[self dealerAction];
		}
		
    }
	
	
	
	
	
    if (player.position == PositionInTableLeft && controlador ==0) {
        if ([self.blackjack.players count] > 3) {
            player = [self.blackjack.players objectAtIndex:3];
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
			[cardLayer changeCardsFor:self.blackjack.dealer];
			//[self dealerAction];
		}
		
    }
	
    if (player.position == PositionInTableRight && controlador ==0) {
        [cardLayer changeCardsFor:self.blackjack.dealer];
		//[self dealerAction];
    }*/
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
	[self setAllPlayersNotReady];
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
		if (player.isHost) {
			[self assignHost];
			
		}
	}
	
}

#pragma mark BlackjackEvents Protocol

-(void) deckIsVoid:(id) bj{
	
	Deck *decktmp = [[Deck alloc] initWithPlist:@"frenchDeck" numDeck:bjprefs.opDeck];
	
	self.blackjack.deck = decktmp;
	
	[decktmp release];
	
}

-(void) playerIsReady:(PlayerBJ *) player blackjack:(id)bj{}

-(void) playerBetted:(PlayerBJ *)player blackjack:(id)bj {
	
	BJChipsLayer *cl = [self getChildByTag:player.position];
	BJChipsBetLayer *cbl = [self getChildByTag:100+player.position];
	[cl drawChips:player];
	[cbl drawChipsBet:player];
	player.isReady = YES;
	
	//getting local player
	PlayerBJ *tmp = [blackjack getPlayerById:[GKLocalPlayer localPlayer].playerID];
	
	
	
	 if ([self checkIfPlayersAreReady] && tmp.isHost && [tmp.playerHand count]==0) {
		NSLog(@"Todos los jugadores listos. Ya hemos finalizado de apostar");
		[self drawCards];
		//cuando todos los jugadores estan listos, volver a poner isReady a false
		[self setAllPlayersNotReady];
	}
	
	
	
	

	/*if (player == [self.blackjack.players lastObject] && [player.playerHand count] == 0) {
		
		[self drawCards];
	}*/
	
	
	
}

-(void) setAllPlayersNotReady
{
	for (PlayerBJ *p  in blackjack.players) {
		p.isReady = NO;
	}
	
}

-(void) playerGotCard:(Card *)card toPlayer:(PlayerBJ *)player blackjack:(id)bj message:(BOOL) message{
	//getting local player
	PlayerBJ *tmp = [self localPlayer];
	if (message) {
		[self sendPacketWithCard1:card  toPlayer:player.playerID withTarget:player.position];

	}

	
	
	
	[self.cardLayer drawCards:player card:card];
	
}

-(void) playerSplited:(PlayerBJ *)player blackjack:(id)bj{}

//- (void) player:(PlayerBJ *)player withResult:(PlayerResult)result blackjack:(id)bj{}

#pragma mark ModalMenuEvents Protocol

-(void) compareWithDealerMade:(PlayerBJ *)p{
	
	[self updatePlayerMoneyLabels:p];
	if ([self localPlayer].isHost) {
		[self localPlayer].isReady = YES;
		if ([self checkIfPlayersAreReady]) {
			[self restartGame];
			[self sendPacketofType:PacketTypeStart];
		}
	}
	
	else {
		[self sendPacketofType:PacketTypeReady];
	}

	
	/*
	PlayerBJ *player;
	switch (p.position) {
			
		case PositionInTableMiddleLeft:
			
			if ([self.blackjack.players count] > 1) {
				//Segundo jugador
				player = [self.blackjack.players objectAtIndex:1];
				
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
			
			if ([self.blackjack.players count] > 2) {
				//Tercer jugador
				player = [self.blackjack.players objectAtIndex:2];
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
			
			if ([self.blackjack.players count] > 3) {
				//Cuarto jugador
				player = [self.blackjack.players objectAtIndex:3];
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
	*/
}

-(void) betMade:(int)bet byPlayer:(PlayerBJ *)p{
	
	//Hacer apuesta del primer jugador
	[self.blackjack addBet:bet player:p];
	
	NSLog(@"%@ has %d", p.playerName, p.money);
	
	
	[self sendPacketofType:PacketTypeBet withBet:p.bet withTarget:p.position];
	
	[self updatePlayerMoneyLabels:p];
	
}

-(void) menuIsHide:(bool)status{
	
	menuIsHide = status;
	
}

-(void) cardButtonPushedBy:(PlayerBJ *)p{
	[self updatePlayerStatus];
	if(p.status == PlayerUnderPuntuation){
		
		[self.blackjack giveCard:1 to:p toHand:PlayerHandFirst];
		
		
		
	/*	PlayerBJ *player;
		
		switch (p.position) {
				
			case PositionInTableMiddleLeft:
				
				player = [blackjack getPlayerAtPosition:PositionInTableRight];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableMiddleRight:
				
				player = [blackjack getPlayerAtPosition:PositionInTableRight];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableLeft:
				
				player = [blackjack getPlayerAtPosition:PositionInTableRight];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			case PositionInTableRight:
				
				//player = [self.blackjack.players objectAtIndex:3];
				player = [blackjack getPlayerAtPosition:PositionInTableRight];
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				
				break;
				
			default:
				break;
		}*/
		
	}
	
}


//stand event method
-(void) continueButtonPushedBy:(PlayerBJ *)p{
	
	[self updatePlayerStatus];
	[self localPlayer].isReady = YES;
	PlayerBJ *tmp = [self localPlayer];
	if ([blackjack.players count]==1) {
		[cardLayer changeCardsFor:blackjack.dealer withCallFunc:YES];

	}
	[self sendPacketofType:PacketTypeStand];
		
	

			
	
}

- (void) doubleBetButtonPushedBy:(PlayerBJ *)p{
	if ([self localPlayer].isHost) {
		if (p.money >= p.bet) {
			p.isReady = NO;
			[self updatePlayerStatus];
			if(p.status == PlayerUnderPuntuation){
				
				PlayerBJ *player;
				player = p;
				[self.blackjack giveCard:1 to:player toHand:PlayerHandFirst];
				[self betMade:p.bet byPlayer:p];
				
				if ([self localPlayer]== p) {
					[self.modalMenu hideActionMenu];
				}
				
				
				
				
				
				
				
			}
			
		}
		
		
	}
	
	else {
		[self sendPacketofType:PacketTypeDouble];
		[self.modalMenu hideActionMenu];
	}

	
	
	[self updatePlayerMoneyLabels:p];
	
}

#pragma mark CardLayerEvents Protocol

-(void) animationCardMade{
	PlayerBJ *player = [self localPlayer];
	[self updatePlayerStatus];	
	if ([self localPlayer].isHost) {
		[self checkPlayerStatus:player];
	}
	//
	/*NSLog(@"Ya hemos terminado de repartir");
	
	
	int controlador = 0;
	int count = [self.blackjack.players count];
	int i=0;
	
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
			
			[cardLayer changeCardsFor:self.blackjack.dealer];
			//[self dealerAction];
			
		}
		
    }*/
	
}

-(void) removeCardMade{
	
	//Menu de apuesta del primer jugador
	if ([self localPlayer].money>0) {
		[self.modalMenu showModalMenuWith:BetMenu playerBJ:[self localPlayer]];
	}
	
	
}

- (void) stateChanged{
	//enviar mensaje de que el dealer ha girado las cartas
	PlayerBJ *tmp = [blackjack getPlayerById:[GKLocalPlayer localPlayer].playerID];
	if (tmp.isHost) {
		[self sendPacketofType:PacketTypeDealerTurns];
		[self dealerAction];

	}
	else {
		[self.cardLayer changeCardsFor:blackjack.dealer withCallFunc:NO];
		//ç[self dealerAction];
	}

	
}

#pragma mark PauseMenuEvents Protocol


-(void) resumePause{
	
	[self.pauseButton setIsEnabled:YES];
	
}

-(void) exitPause{
	int money=0;
	//NSString *str = [NSString stringWithString:@"TMB"];
	
	PlayerBJ *player = [self localPlayer];
	money=money+[self getPuntuation:player];
	//[self sendPacketofType:PacketTypeExit];
	
	int64_t allMoney = money;
	NSString *str = [NSString stringWithString:@"TMB2"];
	[self reportScore:allMoney forCategory:str];
	[self disconnect];
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

-(int) getPuntuation:(PlayerBJ *)player{
	
	if (player.money > 1000) {
		return player.money-1000;
	}else {
		return 0;
	}
	
	
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
				//pos+=3;
				playertmp = [[PlayerBJ alloc] initWithName:[player alias] position:PositionInTableMiddleRight money:1000];
				playertmp.playerID = player.playerID;
				playertmp.playerHash = [player.playerID hash];
				playertmp.isHost = NO;
				playertmp.isReadyForPositions = NO;
				
				[self.blackjack.players addObject:playertmp];
			}
			
			//[blackjack.players sortUsingSelector:@selector(compare:)];
			NSSortDescriptor *sortDescriptor;
			sortDescriptor = [[[NSSortDescriptor alloc] initWithKey:@"playerHash"
														  ascending:YES] autorelease];
			NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
			NSArray *sortedArray;
			blackjack.players = [NSMutableArray arrayWithArray:[blackjack.players sortedArrayUsingDescriptors:sortDescriptors]];
			
			//INITIAL MATCH NEGOTIATION
			[self assignHost];
			//preguntar a todos

			
				
			// Process the array of GKPlayer objects.
			
			
			
						if ([self localPlayer].isHost) {
				[self localPlayer].isReadyForPositions = YES;
				
			}
			
			if(![self localPlayer].isHost)
				[self localPlayer].isReadyForPositions = YES;
			
			else {
				[self localPlayer].isReadyForPositions = YES;
				for (PlayerBJ  *p in blackjack.players) {
					[self sendPacketofType:PacketTypeReadyQuestion toPlayer:p.playerID];
				}
			}
			
			
		/*	int pos = 0;
			if ([self localPlayer].isHost) {
				
				
			}*/
			
			
		
			//[self sendPacketofType:PacketTypeStart];
			
			
		}
		
		
		
	}];
	
}

-(void) assignHost{
	NSMutableArray *arrayHash = [[NSMutableArray alloc] init];
	for (PlayerBJ *p in blackjack.players) {
		[arrayHash addObject:[NSNumber numberWithInt:[p.playerID hash]]];
	}
	
	
	
	[arrayHash sortUsingSelector:@selector(compare:)];
	
	
	PlayerBJ * tmp = ((PlayerBJ*)([blackjack getPlayerByHash:[[arrayHash objectAtIndex:0] intValue]]));
    tmp.isHost = TRUE;
	NSLog(@"player %@ is now the Host of the match", tmp.playerName);
	
}
- (void)match:(GKMatch *)match player:(NSString *)playerID didChangeState:(GKPlayerConnectionState)state

{
	PlayerBJ *player = [self.blackjack getPlayerById:playerID];
	NSLog(@"did change state:%@", playerID);
    switch (state)
	
    {
			
        case GKPlayerStateConnected:
			//[self sendTest:@"mensajitoo"];
			
			NSLog(@"player %@ connected", player.playerName);
			//[blackjack.players ]
			//[self pruevaEnvio];
			//[self sendTest:@"me recibes?"];
			//laodplayerdata asigna el array de players desde game center
			
			
			//empezar partida
			
			
			break;
			
        case GKPlayerStateDisconnected:
			NSLog(@"player %@ disconnected", player.playerName);
			
			//borrar jugador del array de players
			[self.blackjack removePlayer:player];
			
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

-(PlayerBJ *) getNextPlayerByPlayer:(PlayerBJ *)p{
	BOOL found = NO;
	for (int i =1; i<5; i++) {
		
	
		if ([blackjack getPlayerAtPosition:p.position+i]) {
			return [blackjack getPlayerAtPosition:p.position+i];
		}
	}
	
	
}

- (void)match:(GKMatch *)match didReceiveData:(NSData *)data fromPlayer:(NSString *)playerID

{
	NSLog(@"numero de barajas: %d", [blackjack.deck.arrayCards count]);
	Packet incoming;
	CardPacket incomingCard;
	
	PlayerBJ *target; 
    if ([data length] == sizeof(Packet)) {
        [data getBytes:&incoming length:sizeof(Packet)];
		
	}
	
	if ([data length] == sizeof(CardPacket)) {
        [data getBytes:&incomingCard length:sizeof(CardPacket)];
		
	}
	
	PlayerBJ * p =  [blackjack getPlayerById:playerID];
	
	switch (incoming.type) {
			
		case PacketTypeExit:
			[self.blackjack removePlayer:p];
			if (p.isHost) {
				[self assignHost];
			}
			break;
	
		
		
		case PacketTypeBet:
			
			//
			[blackjack addBet:incoming.bet - [blackjack getPlayerAtPosition:incoming.position].bet player:[blackjack getPlayerAtPosition:incoming.position]];
			[self updatePlayerMoneyLabels:p];

			break;
			
		case PacketTypeGotCard:
			
			if (incomingCard.targetHash == 0) {
				target = blackjack.dealer;
			}
			else
				target = [blackjack getPlayerByHash:incomingCard.targetHash];

			[self playerGotCard:[blackjack getCardWithNumber:incomingCard.cardNumber 
														palo:incomingCard.cardPalo] 
					   toPlayer:target blackjack:blackjack message:NO];
			
			break;
			
		case PacketTypeStand:
			[blackjack getPlayerById:playerID].isReady = YES;
			PlayerBJ * p = [blackjack getPlayerById:playerID];
			NSLog(@"player %@ stands with a puntuation of:%d",p.playerName ,[p playerHandPuntuation:PlayerHandFirst]);
			//[self continueButtonPushedBy:nil];
			if ([self localPlayer]) {
				if ([self localPlayer] == [self getNextPlayerByPlayer:p]) {
					[self checkPlayerStatus:[self localPlayer]];
					
				}
			}
			
				

			
			
			
			int index = [blackjack.players indexOfObject:p];
			if ((index == [blackjack.players count]-1) && [self localPlayer].isHost) {
				[cardLayer changeCardsFor:blackjack.dealer withCallFunc:YES];
				[self setAllPlayersNotReady];
			}
			
			break;
			
			
		case PacketTypeDouble:
			if ([self localPlayer].isHost) {
				[self doubleBetButtonPushedBy:[blackjack getPlayerById:playerID]];
			}
			break;

			
		case PacketTypeDealerTurns:
			[self stateChanged];
			
			break;
			
		case PacketTypeDealerDone:
			[self dealerAction];
			break;

			
		case PacketTypeReady:
			if ([self localPlayer].isHost) {
				[blackjack getPlayerById:playerID].isReady = YES;
				if ([self checkIfPlayersAreReady]) {
					[self restartGame];
					[self sendPacketofType:PacketTypeStart];
				}
			}
			
			break;
		case PacketTypeStart:
			
			[self restartGame];
			break;
			
		case PacketTypePosition:
			
			[blackjack getPlayerByHash:incoming.targetHash].position = incoming.position;
			
			
			
			break;
			
		case PacketTypeResult:
			[blackjack getPlayerAtPosition:incoming.position].status = incoming.result;
			[self afterDealer];
			
			break;

		case PacketTypePaint:
			[MainScene replaceLayer:self stopAnimation:NO withAnimation:@"FadeTR"];
			
			[self drawBet];
			
			[self drawChips];
			[self drawPlayerNames];
			[self drawPlayerMoney];
			
			[self startVoiceChat];
			break;

			
			
		case PacketTypeReadyForPositions:
			/*if (myMatch.expectedPlayerCount == 0) {
				[blackjack getPlayerById:playerID].isReadyForPositions = YES;
				if([self checkIfPlayersAreReadyForPositions] && [self localPlayer].isHost)
					[self sendPositions];
			}*/
		
			break;
		
		case PacketTypeReadyQuestion:
			if ([self localPlayer].isReadyForPositions) {
				[self sendPacketofType:PacketTypeYes];
			}
			else {
				[self sendPacketofType:PacketTypeNo];
			}

			break;
			
		case PacketTypeYes:
			if ([self localPlayer].isHost) {
				int pos = 0;
				[blackjack getPlayerById:playerID].isReadyForPositions = YES;
				if ([self checkIfPlayersAreReadyForPositions]) {
					
					
					[self sendPositions];
				}
			}
			break;
		
		case PacketTypeNo:
			if ([self localPlayer].isHost) {
				[self sendPacketofType:PacketTypeReadyQuestion toPlayer:playerID];

			}
		
			break;
		


		default:
			break;
	}
	
	switch (incomingCard.type) {
		case PacketTypeBet:
			
			//
			[blackjack addBet:incoming.bet player:p];
			
			break;
			
		case PacketTypeGotCard:
			
			if (incomingCard.targetHash == PositionInTableTop) {
				target = blackjack.dealer;
			}
			else
				target = [blackjack getPlayerAtPosition:incomingCard.targetHash];
			Card *tmpCard = [blackjack getCardWithNumber:incomingCard.cardNumber
													palo:incomingCard.cardPalo];
			[target addCard:tmpCard  toHand:PlayerHandFirst];
			[self playerGotCard:tmpCard
					   toPlayer:target blackjack:blackjack message:NO];
 			
			break;
			
		default:
			break;
	}
	
	
	// Packet *p = (Packet*)[data bytes];
	//int bet = p
	
	
	
	
	
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
	[self sendPacketofType:PacketTypeStart];
	
}

- (void) sendPacketofType: (PacketType)aType
{
	
	
		
	
	NSError *error=nil;
	
    Packet msg;
	
	
	
	msg.type = aType;
	
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
	
    [myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
}

- (void) sendPacketofType: (PacketType)aType withResult:(PlayerResult)aResult withTarget:(PositionInTable) aPosition
{
	NSError *error=nil;
	
    Packet msg;
	msg.puntuation =21;
	
	msg.bet = 100;
	msg.result = aResult;
	msg.position = aPosition;
	msg.type = aType;
	
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
	
    [myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
}



- (void) sendPacketofType: (PacketType)aType toPlayer:(NSString *)playerID{
	NSError *error=nil;
	
    Packet msg;
	
	
	
	
	msg.type = aType;
	
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
	[myMatch sendData:packetData toPlayers:[NSArray arrayWithObject:playerID] withDataMode:GKMatchSendDataReliable error:&error];
    //[myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
	
	
}

- (void) sendPacketofType: (PacketType)aType withBet:(int) bet{
	NSError *error=nil;
	
    Packet msg;
	
	
	msg.bet = bet;
	
	msg.type = aType;
	
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
	
    [myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
}

- (void) sendPacketofType: (PacketType)aType withBet:(int) bet withTarget:(PositionInTable) targetPosition{
	NSError *error=nil;
	
    Packet msg;
	msg.position = targetPosition;
	
	msg.bet = bet;
	
	msg.type = aType;
	
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
	
    [myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
}

- (void) sendPacketWithPosition:(PositionInTable) pos ofPlayer:(NSString *) playerID
{
	NSError *error=nil;
	
    Packet msg;
	
	
	msg.position = pos;
	
	msg.type = PacketTypePosition;
	msg.targetHash = [playerID hash];
	
	
    NSData *packetData = [NSData dataWithBytes:&msg length:sizeof(Packet)];
	
    [myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	
	
}



- (void) sendPacketWithCard1:(Card*) card1 toPlayer:(NSString *) playerID withTarget:(int) targetHash{
	NSError *error=nil;
	
    CardPacket msg1;
	msg1.type = PacketTypeGotCard;
	msg1.targetHash = targetHash;
	
	int a = [playerID hash];
	if ([card1.palo isEqualToString:@"corazon"]) {
		msg1.cardPalo = paloCorazon;
	}
	else if ([card1.palo isEqualToString:@"pica"]) {
		msg1.cardPalo = PaloPica;
	}
	else if ([card1.palo isEqualToString:@"diamante"]) {
		msg1.cardPalo = PaloDiamante;
	}
	else if ([card1.palo isEqualToString:@"trebol"]) {
		msg1.cardPalo = PaloTrebol;
	}
	
	
	if ([card1.num isEqualToString:@"A"]) {
		msg1.cardNumber = 14;
	}
	else if ([card1.num isEqualToString:@"K"]) {
		msg1.cardNumber = 13;
	}
	else if ([card1.num isEqualToString:@"Q"]) {
		msg1.cardNumber = 12;
	}
	else if ([card1.num isEqualToString:@"J"]) {
		msg1.cardNumber = 11;
	}
	else 
		msg1.cardNumber = [card1.num intValue];
	//[self buildPacketForCard:card1 packet:msg1];
	
	
	//msg.card1 = card1;
	//msg.card2 = card2;
	
    NSData *packetData = [NSData dataWithBytes:&msg1 length:sizeof(CardPacket)];
	
	[myMatch sendDataToAllPlayers:packetData withDataMode:GKMatchSendDataReliable error:&error];
	

	
	//[myMatch sendData:packetData toPlayers:array withDataMode:GKMatchSendDataReliable error:&error];
    //[myMatch sendDataToAllPlayers: packetData withDataMode: GKMatchSendDataReliable error:&error];
	
    if (error != nil)
		
    {
		NSLog(@"Error sending message: %@", [error localizedDescription]);
        // handle the error
		
    }
	error = nil;
	
	
	
	
}


-(void) buildPacketForCard:(Card *) card1 packet:(CardPacket) msg1
{
	
	msg1.type = PacketTypeGotCard;
	msg1.cardNumber = [card1.num intValue];
	
	if ([card1.palo isEqualToString:@"corazon"]) {
		msg1.cardPalo = paloCorazon;
	}
	else if ([card1.palo isEqualToString:@"pica"]) {
		msg1.cardPalo = PaloPica;
	}
	else if ([card1.palo isEqualToString:@"diamante"]) {
		msg1.cardPalo = PaloDiamante;
	}
	else if ([card1.palo isEqualToString:@"trebol"]) {
		msg1.cardPalo = PaloTrebol;
	}
	
	/*switch (card1.palo) {
		case [card1.palo isEqualToString:@"corazon"]:
			msg1.cardPalo = paloCorazon;
			break;
		case [card1.palo isEqualToString:@"pica"]:
			msg1.cardPalo = PaloPica;
			break;
		case [card1.palo isEqualToString:@"diamante"]:
			msg1.cardPalo = PaloDiamante;
			break;
		case [card1.palo isEqualToString:@"trebol"]:
			msg1.cardPalo = PaloTrebol;
			break;
		default:
			break;
	}*/
	
	
	
	
}


-(BOOL) checkIfPlayersAreReady
{
	
	for (PlayerBJ * player in blackjack.players) {
		if (!player.isReady) {
			return	NO;
		}
	}
	return YES;
	
	
}
-(BOOL) checkIfPlayersAreReadyForPositions
{
	
	for (PlayerBJ * player in blackjack.players) {
		if (!player.isReadyForPositions) {
			return	NO;
		}
	}
	return YES;
	
	
}

//devuelve un objeto de la clase playerbj con el jugador local

- (PlayerBJ *) localPlayer
{
	return [blackjack getPlayerById:[GKLocalPlayer localPlayer].playerID];
	
	
	
	
}

-(void) sendPositions{
	
	int pos = 0;
	[self localPlayer].position = pos;
	[self sendPacketWithPosition:pos ofPlayer:[self localPlayer].playerID];
	
	
	
	for (PlayerBJ * p in blackjack.players) {
		
		
		
		if (!p.isHost) {
			p.position = pos;
			[self sendPacketWithPosition:pos ofPlayer:p.playerID];
		}
		pos++;
		
	}
	
	[self drawBet];
	
	[self drawChips];
	[self drawPlayerNames];
	[self drawPlayerMoney];
	
	[MainScene replaceLayer:self stopAnimation:NO withAnimation:@"FadeTR"];
	[self sendPacketofType:PacketTypePaint];
	[self startVoiceChat];
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
		PlayerBJ * p = [blackjack getPlayerById:playerID];
			
		CCSprite * sound = [self getChildByTag:p.position+666];
			switch (state)
			
			{
					
				case GKVoiceChatPlayerSpeaking:
					NSLog(@"player speaking");
					// insert code to highlight the player.
					
					[sound runAction:[CCFadeIn actionWithDuration:0.1]];
					break;
					
				case GKVoiceChatPlayerSilent:
					NSLog(@"player silent");
					// insert code to dim the player.
					[sound runAction:[CCFadeOut actionWithDuration:0.1]];
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
