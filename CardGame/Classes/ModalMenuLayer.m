//
//  ModalMenuLayer.m
//  CardGame
//
//  Created by Fran on 07/10/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ModalMenuLayer.h"


@implementation ModalMenuLayer

@synthesize bet, delegate;
@synthesize chip10Button,chip25Button,chip100Button,chip200Button,chip500Button,restartButton,makeBetButton,clearBetButton,betLabel;
@synthesize doubleButton,callCardButton,standButton,okButton;
@synthesize nameLabel, dealerName;
@synthesize continueButton,playerScore,dealerScore;
@synthesize background,menu,menuGame,menuCompare,player,dealer,result;

-(id) init{
	
	if( (self=[super init])) {
		
		CGSize s = [[CCDirector sharedDirector] winSize];
		
		bjprefs = [BlackJackSettings sharedSettings];
		
		//Añado el fondo
		self.background = [[CCSprite alloc] initWithFile:@"ModalMenu.png"];
		[self.background setAnchorPoint:ccp(1, 0.5)];
		//background.position = ccp(-background.contentSize.width,0);
		self.background.position = ccp(-self.background.contentSize.width,s.height/2);
		[self addChild:self.background z:1];
		
		self.bet=0;
		
		int margin = 15;
		
		//ELEMENTOS DEL MENU APUESTA
		
		self.chip10Button = [CCMenuItemImage itemFromNormalImage:@"ficha10Button.png" selectedImage:@"ficha10Button.png" target:self selector:@selector(makeBet10)];
		self.chip10Button.anchorPoint = ccp(0,0.5);
		self.chip10Button.position = ccp(margin , s.height/2);
		
		int chipButtonWidth = chip10Button.contentSize.width;
		
		self.chip25Button = [CCMenuItemImage itemFromNormalImage:@"ficha25Button.png" selectedImage:@"ficha25Button.png" target:self selector:@selector(makeBet25)];
		self.chip25Button.anchorPoint = ccp(0,0.5);
		self.chip25Button.position = ccp(margin*2+chipButtonWidth , s.height/2);
		
		self.chip100Button = [CCMenuItemImage itemFromNormalImage:@"ficha100Button.png" selectedImage:@"ficha100Button.png" target:self selector:@selector(makeBet100)];
		self.chip100Button.anchorPoint = ccp(0,0.5);
		self.chip100Button.position = ccp(margin*3+chipButtonWidth*2 , s.height/2);
		
		self.chip200Button = [CCMenuItemImage itemFromNormalImage:@"ficha200Button.png" selectedImage:@"ficha200Button.png" target:self selector:@selector(makeBet200)];
		self.chip200Button.anchorPoint = ccp(0,0.5);
		self.chip200Button.position = ccp(margin*4+chipButtonWidth*3 , s.height/2);
		
		self.chip500Button = [CCMenuItemImage itemFromNormalImage:@"ficha500Button.png" selectedImage:@"ficha500Button.png" target:self selector:@selector(makeBet500)];
		self.chip500Button.anchorPoint = ccp(0,0.5);
		self.chip500Button.position = ccp(margin*5+chipButtonWidth*4 , s.height/2);
		
		CCLabel *clearBetLabel = [CCLabel labelWithString:NSLocalizedString(@"clear", @"clear") fontName:@"Royalacid_o" fontSize:20];
		self.clearBetButton = [CCMenuItemFont itemWithLabel:clearBetLabel target:self selector:@selector(clearBet)];
		self.clearBetButton.anchorPoint = ccp(0,0.5);
		self.clearBetButton.position = ccp(margin*6+chipButtonWidth*5 , s.height/2-margin);
		
		CCLabel *makeBetLabel = [CCLabel labelWithString:NSLocalizedString(@"makeBet", @"makeBet") fontName:@"Royalacid_o" fontSize:20];
		self.makeBetButton = [CCMenuItemFont itemWithLabel:makeBetLabel target:self selector:@selector(hideBetMenu)];
		self.makeBetButton.anchorPoint = ccp(0,0.5);
		self.makeBetButton.position = ccp(clearBetButton.position.x+clearBetButton.contentSize.width+margin , s.height/2-margin);
		
		self.betLabel = [CCLabel labelWithString:[NSString stringWithFormat:@"%d ",self.bet] fontName:@"Royalacid_o" fontSize:30];
		self.betLabel.anchorPoint = ccp(0,0.5);
		self.betLabel.position = ccp(margin*6+chipButtonWidth*5 , s.height/2+margin);
		self.betLabel.opacity = 0.0;
		
		//Añado los elementos a self
		[self addChild:betLabel z:2];
		
		//Añado los elementos al menu y añado el menu
		self.menu = [CCMenu menuWithItems:chip10Button, chip25Button, chip100Button, chip200Button, chip500Button, clearBetButton, makeBetButton, nil];
		self.menu.position = ccp(0,0);
		self.menu.opacity = 0.0;
		[self addChild:self.menu z:3];
		[self disableMenu:self.menu set:YES];
		
		//FIN ELEMENTOS DEL MENU APUESTA
		
		
		//int lastWidth = 0;
		//int lastx = 0;
		
		//ELEMENTOS DEL MENU ACCION
		
		CCLabel *doubleLabel = [CCLabel labelWithString:NSLocalizedString(@"double", @"double") fontName:@"Royalacid_o" fontSize:25];
		self.doubleButton = [CCMenuItemLabel itemWithLabel:doubleLabel target:self selector:@selector(doubleBet)];
		//doubleButton.anchorPoint = ccp(0,0.5);
		//doubleButton.position = ccp(margin, s.height/2);
		//lastWidth = doubleButton.contentSize.width;
		//lastx = doubleButton.position.x;
		
		CCLabel *callCardLabel = [CCLabel labelWithString:NSLocalizedString(@"callCard", @"callCard") fontName:@"Royalacid_o" fontSize:25];
		self.callCardButton = [CCMenuItemLabel itemWithLabel:callCardLabel target:self selector:@selector(callCard)];
		//callCardButton.anchorPoint = ccp(0,0.5);
		//callCardButton.position = ccp(lastx+lastWidth+margin, s.height/2);
		//lastWidth = callCardButton.contentSize.width;
		//lastx = callCardButton.position.x;
		
		CCLabel *standLabel = [CCLabel labelWithString:NSLocalizedString(@"stand", @"stand") fontName:@"Royalacid_o" fontSize:25];
		self.standButton = [CCMenuItemLabel itemWithLabel:standLabel target:self selector:@selector(makeBet)];
		//standButton.anchorPoint = ccp(0,0.5);
		//standButton.position = ccp(lastx+lastWidth+margin, s.height/2);
		//lastWidth = standButton.contentSize.width;
		//lastx = standButton.position.x;
		
		CCLabel *okLabel = [CCLabel labelWithString:NSLocalizedString(@"handOk", @"handOk") fontName:@"Royalacid_o" fontSize:25];
		self.okButton = [CCMenuItemLabel itemWithLabel:okLabel target:self selector:@selector(hideActionMenu)];
		//okButton.anchorPoint = ccp(0,0.5);
		//okButton.position = ccp(lastx+lastWidth+margin, s.height/2);
		
		
		//Añado los elementos al menu y añado el menu
		//self.menuGame = [CCMenu menuWithItems:doubleButton, callCardButton, /*standButton,*/ okButton, nil];
		self.menuGame = [CCMenu menuWithItems:nil];
		
		if (bjprefs.opDouble) {
			[self.menuGame addChild:doubleButton];
		}
		
		[self.menuGame addChild:callCardButton];
		[self.menuGame addChild:okButton];
		
		//Configuro el menu
		[self.menuGame alignItemsHorizontallyWithPadding:20];
		[self.menuGame setAnchorPoint:ccp(0.5,0.5)];
		self.menuGame.position = ccp(s.width/2,s.height/2);
		self.menuGame.opacity = 0.0;
		
		[self addChild:self.menuGame z:3];
		[self disableMenu:self.menuGame set:YES];
		
		
		//FIN ELEMENTOS DEL MENU ACCION
		
		
		
		//ELEMENTOS DEL MENU COMPARE
		self.dealerName = [CCLabel labelWithString:@"Dealer" fontName:@"Royalacid_o" fontSize:20];
		self.dealerName.anchorPoint = ccp(1,0.5);
		self.dealerName.position = ccp(s.width-5,s.height/2+30);
		self.dealerName.opacity = 0.0;
		[self addChild:self.dealerName z:2];
		
		
		CCLabel *continueLabel = [CCLabel labelWithString:NSLocalizedString(@"handOk", @"handOk") fontName:@"Royalacid_o" fontSize:25];
		self.continueButton = [CCMenuItemLabel itemWithLabel:continueLabel target:self selector:@selector(hideCompareMenu)];
		//continueButton.anchorPoint = ccp(0,0.5);
		//continueButton.position = ccp(lastx+lastWidth+margin, s.height/2);
		
		self.playerScore = [CCLabel labelWithString:@"pp" fontName:@"Royalacid_o" fontSize:25];
		self.playerScore.anchorPoint = ccp(0,0.5);
		self.playerScore.position = ccp(5,s.height/2);
		self.playerScore.opacity = 0.0;
		[self addChild:self.playerScore z:2];
		
		
		self.dealerScore = [CCLabel labelWithString:@"dd" fontName:@"Royalacid_o" fontSize:25];
		self.dealerScore.anchorPoint = ccp(1,0.5);
		self.dealerScore.position = ccp(s.width-5,s.height/2);
		self.dealerScore.opacity = 0.0;
		[self addChild:self.dealerScore z:2];
		

		
		//Añado los elementos al menu y añado el menu
		self.menuCompare = [CCMenu menuWithItems:continueButton, nil];
		//Configuro el menu
		[self.menuCompare alignItemsHorizontallyWithPadding:20];
		[self.menuCompare setAnchorPoint:ccp(0.5,0.5)];
		self.menuCompare.position = ccp(s.width/2,s.height/2);
		self.menuCompare.opacity = 0.0;
		
		[self addChild:self.menuCompare z:3];
		[self disableMenu:self.menuCompare set:YES];
		
		
		
		//FIN ELEMENTOS DEL MENU COMPARE
		
		
		self.nameLabel = [CCLabel labelWithString:@"" fontName:@"Royalacid_o" fontSize:20];
		self.nameLabel.anchorPoint = ccp(0,0.5);
		self.nameLabel.position = ccp(0,s.height/2+30);
		self.nameLabel.opacity = 0.0;
		[self addChild:self.nameLabel z:2];
		
		
	}
	return self;
}

- (void) dealloc{
	//Elementos menu Accion
	//rellenar
	
	//Elementos menu apuesta
	//rellenar

	//Elementos menu Compare
	[self.dealerName release];
	
	[super dealloc];

}

- (void) showCompareMenu:(PlayerBJ *)p dealer:(PlayerBJ *)d result:(PlayerResult)r {
	
	self.result = r;
	self.dealer = d;
	[self showModalMenuWith:CompareMenu playerBJ:p];
	
}

- (void) showModalMenuWith:(ModalMenuClass) mmc playerBJ:(PlayerBJ *)p{
	
	CGSize s = [[CCDirector sharedDirector] winSize];
	
	[self.delegate menuIsHide:NO];
	
	self.player = p;
	//Blackjack *d = [self.delegate];

	
	[self.nameLabel setString:p.playerName];
	
	mmclass = mmc;
	
	CCAction *backgroundDelay = [CCDelayTime actionWithDuration:DELAYANIMATION];
	CCAction *backgroundAction = [CCMoveTo actionWithDuration:DURATIONBACK position:ccp(background.contentSize.width, s.height/2)];
	CCAction *fadeInAction1 = [CCFadeIn actionWithDuration:DURATIONCONTENT];
	CCAction *fadeInAction2 = [CCFadeIn actionWithDuration:DURATIONCONTENT];
	CCAction *fadeInAction3 = [CCFadeIn actionWithDuration:DURATIONCONTENT];
	CCAction *fadeInAction4 = [CCFadeIn actionWithDuration:DURATIONCONTENT];
	CCAction *fadeInAction5 = [CCFadeIn actionWithDuration:DURATIONCONTENT];
	
	[self.nameLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
						 fadeInAction1,
						 nil]];
	
	int iP =[p playerHandPuntuation:PlayerHandFirst];
	int iD =[self.dealer playerHandPuntuation:PlayerHandFirst];
	
	//Animo el fondo
	[self.background runAction:[CCSequence actions:backgroundDelay,
								backgroundAction,
								nil]];
	
	switch (mmc) {
			
		case BetMenu:
			
			self.bet=0;
			[self.betLabel setString:[NSString stringWithFormat:@"%d ", self.bet]];
			
			//Añado el label de la apuesta y lo animo para mostrarlo
			[self.betLabel runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
								 fadeInAction2,
								 nil]];
			
			//Animo el menu
			[self.menu runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
							 fadeInAction3,
							 nil]];
			
			[self disableMenu:menu set:NO];
			
			break;
			
		case ActionMenu:
			
			//Animo el menu
			[self.menuGame runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
								 fadeInAction2,
								 nil]];
			
			[self disableMenu:menuGame set:NO];
			break;
			
		case CompareMenu:
			
			if (iP == -1) {
				[self.playerScore setString:@"BlackJack!!!"];
			}else {
				[self.playerScore setString:[NSString stringWithFormat:@"%d",iP]];
			}
			
			if (iD == -1) {
				[self.dealerScore setString:@"BlackJack!!!"];
			}else {
				[self.dealerScore setString:[NSString stringWithFormat:@"%d",iD]];
			}

			
			if (self.result == PlayerWin) {
				[self.continueButton setString:@"WIN"];
			}else if (self.result == PlayerLose) {
				[self.continueButton setString:@"LOSE"];
			}else {
				[self.continueButton setString:@"TIE"];
			}
			
			[self.playerScore runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
										 fadeInAction2,
										 nil]];
			
			
			[self.dealerScore runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
										 fadeInAction3,
										 nil]];
			
			[self.dealerName runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
								  fadeInAction4,
								  nil]];
			
			//Animo el menu
			[self.menuCompare runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYCONTENT+DELAYANIMATION],
									  fadeInAction5,
									  nil]];
			
			
			[self disableMenu:menuCompare set:NO];
			break;
			
		default:
			break;
			
	}
	
}

//Selector para llamar a hideModalMenuWith:
- (void) hideBetMenu{
	
	if (self.bet==0){
		//mostrar mensaje... ¡¡Apuesta imposible, debe ser mayor a 0!!!
		self.bet=0;
		[betLabel setString:[NSString stringWithFormat:@"%d ", self.bet]];
	}
	else if (self.bet <= self.player.money) {
		[self hideModalMenuWith:BetMenu];
		
		id act = [CCDelayTime actionWithDuration:1.5];
		id act2 = [CCCallFunc actionWithTarget:self selector:@selector(makeBet)];
		
		[self runAction:[CCSequence actions:act,act2,nil]];
	}else {
		//mostrar mensaje... ¡¡Apuesta imposible, dinero insuficiente!!!
		self.bet=0;
		[betLabel setString:[NSString stringWithFormat:@"%d ", self.bet]];
	}
	
}
- (void) hideActionMenu{
	
	[self hideModalMenuWith:ActionMenu];
		
	id act = [CCDelayTime actionWithDuration:1.5];
	id act2 = [CCCallFunc actionWithTarget:self selector:@selector(nextPlayer)];
		
	[self runAction:[CCSequence actions:act,act2,nil]];
	
}

- (void) hideCompareMenu {

	[self hideModalMenuWith:CompareMenu];
	
	id act = [CCDelayTime actionWithDuration:1.5];
	id act2 = [CCCallFunc actionWithTarget:self selector:@selector(nextCompare)];
	
	[self runAction:[CCSequence actions:act,act2,nil]];
}

-(void) hideModalMenuWith:(ModalMenuClass)mmc {
	
	[self.delegate menuIsHide:YES];
	
	CCAction *action1 = [CCMoveBy actionWithDuration:DELAYCONTENT position:ccp(-background.contentSize.width, 0)];
	CCAction *fadeOutAction1 = [CCFadeOut actionWithDuration:DURATIONCONTENT];
	CCAction *fadeOutAction2 = [CCFadeOut actionWithDuration:DURATIONCONTENT];
	CCAction *fadeOutAction3 = [CCFadeOut actionWithDuration:DURATIONCONTENT];
	CCAction *fadeOutAction4 = [CCFadeOut actionWithDuration:DURATIONCONTENT];
	CCAction *fadeOutAction5 = [CCFadeOut actionWithDuration:DURATIONCONTENT];
	
	//Animo el label de la apuesta
	[nameLabel runAction:fadeOutAction1];

	switch (mmc) {
			
		case BetMenu:
			
			//Animo el label de la apuesta
			[betLabel runAction:fadeOutAction2];
			
			//Animo el menu
			[menu runAction: fadeOutAction3];
			
			[self disableMenu:menu set:YES];
			
			break;
			
		case ActionMenu:
			
			//Animo el menu
			[menuGame runAction: fadeOutAction2];
			[self disableMenu:menuGame set:YES];
			break;
			
		case CompareMenu:
			[self.dealerName runAction:fadeOutAction2];
			[self.playerScore runAction:fadeOutAction3];
			[self.dealerScore runAction:fadeOutAction4];
			
			//Animo el menu
			[menuCompare runAction: fadeOutAction5];
			
			[self disableMenu:menuCompare set:YES];
			break;
			
		default:
			break;
	}
	
	//Animo el fondo
	[background runAction:[CCSequence actions:[CCDelayTime actionWithDuration:DELAYBACK],
						   action1,
						   //[CCCallFunc actionWithTarget:self selector:@selector(removeMenu)],
						   nil]];
	
}

-(void) disableMenu:(CCMenu *)m set:(BOOL) disabled{
	
	NSArray *ar=[m children];
	for(CCMenuItem *item in ar)
		[item setIsEnabled:!disabled];
}

/*-(void)resume{
	
	[self hideModalMenuWith:OptionsMenu];
	
}*/

- (void) makeBet10{
	self.bet+=10;
	[betLabel setString:[NSString stringWithFormat:@"%d ", bet]];
}
- (void) makeBet25{
	self.bet+=25;
	[betLabel setString:[NSString stringWithFormat:@"%d ", bet]];
}
- (void) makeBet100{
	self.bet+=100;
	[betLabel setString:[NSString stringWithFormat:@"%d ", bet]];
}
- (void) makeBet200{
	self.bet+=200;
	[betLabel setString:[NSString stringWithFormat:@"%d ", bet]];
}
- (void) makeBet500{
	self.bet+=500;
	[betLabel setString:[NSString stringWithFormat:@"%d ", bet]];
}

- (void) clearBet{

	self.bet = 0;
	[betLabel setString:[NSString stringWithFormat:@"%d ",self.bet]];
	
}

- (void) makeBet{
	
	if([self.delegate respondsToSelector:@selector(betMade:byPlayer:)])
		[self.delegate betMade:self.bet byPlayer:self.player];
	
}

- (void) callCard{

	[self.delegate cardButtonPushedBy:self.player];

}

- (void) nextPlayer{

	if([self.delegate respondsToSelector:@selector(continueButtonPushedBy:)])
		[self.delegate continueButtonPushedBy:self.player];
	
}

- (void) doubleBet{

	if([self.delegate respondsToSelector:@selector(doubleBetButtonPushedBy:)])
		[self.delegate doubleBetButtonPushedBy:self.player];

}

- (void) nextCompare {
	if([self.delegate respondsToSelector:@selector(compareWithDealerMade:)])
		[self.delegate compareWithDealerMade:self.player];
}

@end
